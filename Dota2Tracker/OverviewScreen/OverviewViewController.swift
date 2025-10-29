import UIKit

final class OverviewViewController: UIViewController {

    var data = Players.mockData()
    var customNavBar = CustomNavBar()

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func setupView() {
        view.addSubview(bg)
        view.addSubview(customNavBar)
        view.addSubview(tableView)
    }

    private func setupLayoutTableView() {
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 50),

            tableView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension OverviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayersCell.reuseId, for: indexPath) as? PlayersCell else {
            fatalError("Ячейка не найдена")
        }

        let item = data[indexPath.row]
        cell.setupCell(data: item)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.dropShadow(opacity: 0.3, radius: 0.5)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let detailVC = DetailViewController()
            let selectedItem = data[indexPath.row]
            detailVC.data = selectedItem
            navigationController?.pushViewController(detailVC, animated: true)
        }
}
