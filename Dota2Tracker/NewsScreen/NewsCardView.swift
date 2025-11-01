import SwiftUI
import SafariServices

struct NewCardView: View {
    let title: String
    let imageURL: URL?
    let tapURL: URL?

    @State private var showSafari = false
    var body: some View {
        Button {
            showSafari = true
        } label: {
            ZStack(alignment: .bottomLeading) {
                GradientBackgroundRepresentable()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .allowsHitTesting(false)

                GeometryReader { geo in
                    AsyncImage(url: imageURL) { img in
                        switch img {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geo.size.width, height: geo.size.height)
                                .clipped()
                        case .failure:
                            ZStack {
                                Color.white.opacity(0.04)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .tint(.white)
                                    .scaleEffect(1.2)
                            }
                        case .empty:
                            ZStack {
                                Color.white.opacity(0.04)
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .tint(.white)
                                    .scaleEffect(1.2)
                            }
                        @unknown default:
                            Color.white.opacity(0.04)
                        }
                    }

                }
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .allowsHitTesting(false)
                LinearGradient(
                    colors: [Color.black.opacity(0.55), .clear],
                    startPoint: .bottom,
                    endPoint: .center
                )

                VStack(alignment: .leading) {
                    Text("PATCH NOTES")
                        .font(.caption.weight(.bold))
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(Color.purple.opacity(0.35), in: Capsule())
                        .foregroundColor(.white.opacity(0.95))

                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .lineLimit(2)
                }
                .padding(12)
            }
            .frame(height: 110)
            .frame(maxWidth: .infinity)
            .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
        .sheet(isPresented: $showSafari) {
            if let tapURL { SafariView(url: tapURL) }
        }
    }
}

private struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController {
        .init(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
