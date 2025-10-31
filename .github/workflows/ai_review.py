import os, sys, subprocess, json, requests

REPO      = os.environ["REPO_FULL"]
PR_NUMBER = os.environ["PR_NUMBER"]
BASE      = os.environ["BASE_SHA"]
HEAD      = os.environ["HEAD_SHA"]
GH_TOKEN  = os.environ["GITHUB_TOKEN"]

AI_URL    = os.getenv("AI_API_URL", "https://api.intelligence.io.solutions/api/v1/chat/completions").strip()
AI_KEY    = os.getenv("AI_API_KEY", "").strip()
AI_MODEL  = os.getenv("AI_API_MODEL", "openai/gpt-oss-120b").strip()

def run(cmd):
    return subprocess.check_output(cmd, shell=True, text=True, stderr=subprocess.STDOUT)

try:
    diff = run(f'git diff --unified=0 --no-color "{BASE}" "{HEAD}"')
except subprocess.CalledProcessError as e:
    print("::error::git diff failed:", e.output)
    sys.exit(1)

if not diff.strip():
    print("::notice::Empty diff. Nothing to review.")
    sys.exit(0)

files = []
current = None
new_line = None

for line in diff.splitlines():
    if line.startswith("diff --git "):
        current = {"path": None, "hunks": []}
        files.append(current)
        new_line = None
    elif line.startswith("+++ b/"):
        if current:
            current["path"] = line[len("+++ b/"):].strip()
    elif line.startswith("@@"):
        # @@ -oldStart,oldLen +newStart,newLen @@
        try:
            marker = line.split("@@")[1].strip()
            plus = [p for p in marker.split() if p.startswith('+')][0][1:]
            new_line = int(plus.split(',')[0]) if ',' in plus else int(plus)
            current["hunks"].append({"start": new_line, "lines": []})
        except Exception:
            pass
    else:
        if current and current["hunks"]:
            h = current["hunks"][-1]
            if line.startswith('+') and not line.startswith('+++'):
                h["lines"].append({"line": new_line, "text": line[1:]})
                new_line += 1
            elif line.startswith('-') and not line.startswith('---'):
                pass
            else:
                new_line += 1

MAX_CHARS = 120_000
diff_trimmed = diff if len(diff) <= MAX_CHARS else diff[:MAX_CHARS] + "\n\n...[TRIMMED]"

system_prompt = """You are a senior iOS reviewer for a UIKit-only Swift project (no storyboards).
Review the PR diff and produce inline comments ONLY on newly-added lines.
Focus on: retain cycles ([weak self]), main-thread UI, Auto Layout misuse (constraints in viewDidLayoutSubviews),
accessibility labels/hints, error handling, secrets in repo, background networking, localization, Core Animation performance.
Return STRICT JSON:
{
  "summary": "short bullet summary in markdown",
  "comments": [
    {"path": "path/to/file.swift", "line": 123, "body": "actionable suggestion in markdown"}
  ]
}
Paths must match +++ b/<path> in diff. Lines must refer to added lines only.
"""

user_prompt = f"<diff>\n{diff_trimmed}\n</diff>"

payload = {
    "model": AI_MODEL,
    "temperature": 0.2,
    "messages": [
        {"role": "system", "content": system_prompt},
        {"role": "user",   "content": user_prompt}
    ]
}

headers = {"Content-Type": "application/json"}
# Если твоему сервису нужен ключ — используем Bearer
if AI_KEY:
    headers["Authorization"] = f"Bearer {AI_API_KEY}"

try:
    r = requests.post(AI_URL, headers=headers, json=payload, timeout=120)
    r.raise_for_status()
    data = r.json()
    content = data.get("choices", [{}])[0].get("message", {}).get("content", "")
except Exception as e:
    content = json.dumps({"summary": f"AI endpoint error: {e}", "comments": []})

def extract_json(s: str):
    s = s.strip()
    try:
        i = s.find('{'); j = s.rfind('}')
        return json.loads(s[i:j+1])
    except Exception:
        return {"summary": (s[:2000] or "No content from AI"), "comments": []}

result   = extract_json(content)
summary  = result.get("summary", "AI review")
comments = result.get("comments", [])
if not isinstance(comments, list):
    comments = []

added_map = {}
for f in files:
    if not f["path"]:
        continue
    added = {ln["line"] for h in f["hunks"] for ln in h["lines"]}
    added_map[f["path"]] = added

filtered = []
for c in comments:
    path = c.get("path"); line = c.get("line"); body = (c.get("body") or "").strip()
    if path in added_map and isinstance(line, int) and line in added_map[path] and body:
        filtered.append({"path": path, "line": line, "side": "RIGHT", "body": body})

# ---- 5) Публикуем Review с inline-комментами (или хотя бы summary)
session = requests.Session()
session.headers.update({
    "Authorization": f"Bearer {GH_TOKEN}",
    "Accept": "application/vnd.github+json",
})

review_url = f"https://api.github.com/repos/{REPO}/pulls/{PR_NUMBER}/reviews"
issues_url = f"https://api.github.com/repos/{REPO}/issues/{PR_NUMBER}/comments"

if filtered:
    body = {"event": "COMMENT", "body": summary or "AI Review", "comments": filtered[:50]}
    resp = session.post(review_url, json=body, timeout=60)
    if resp.status_code >= 300:
        # fallback: общий коммент
        session.post(issues_url, json={"body": f"**AI Review**\n\n{summary}"}, timeout=60)
else:
    session.post(issues_url, json={"body": f"**AI Review**\n\n{summary}"}, timeout=60)

print("AI inline review done.")
