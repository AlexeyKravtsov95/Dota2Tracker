import UIKit

final class OverviewViewController: UIViewController {

    var players: [Player] = []

    private lazy var bg: GradientBackgrounView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(GradientBackgrounView())

    lazy var tableView: UITableView = {
        $0.register(PlayersCell.self, forCellReuseIdentifier: PlayersCell.reuseId)
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .insetGrouped))

    private lazy var titleLabel: UILabel = {
        $0.text = "Игроки".uppercased()
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 24, weight: .regular)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Palette.TabBar.selectedItemColor

        setupView()
        setupLayoutTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollability()
    }

    func updateScrollability() {
        let contentHeight = tableView.contentSize.height
        let screenHeight = tableView.bounds.size.height
        tableView.isScrollEnabled = contentHeight > screenHeight
    }

    private func setupView() {
        self.navigationItem.titleView = titleLabel as UILabel
        view.addSubview(bg)
        view.addSubview(tableView)
    }

    private func setupLayoutTableView() {
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension OverviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayersCell.reuseId, for: indexPath) as? PlayersCell else {
            fatalError("Ячейка не найдена")
        }

        let player = players[indexPath.row]
        cell.setupCell(data: player)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.dropShadow(opacity: 0.3, radius: 0.5)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tabBarController = MainTabBarController()

        if let window = view.window?.windowScene?.windows.first {
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = tabBarController
            }, completion: nil)
        }
    }
}
