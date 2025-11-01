import UIKit

final class MainTabBarController: UITabBarController {
    private let selected = Palette.TabBar.selectedItemColor
    private let nonSelected = Palette.TabBar.nonSelectedItemColor
    private let main = Palette.TabBar.mainColor

    //App Controllers
    let playerNavBarController = UINavigationController(rootViewController: OverviewViewController())
    let ladderNavBarController = UINavigationController(rootViewController:LadderViewController())
    let analyticsNavBarController = UINavigationController(rootViewController:AnalyticsViewController())

    //TabBar Buttons
    private lazy var houseButton = getButton(icon: "house.fill", tag: 0, action: action, tintColor: selected)
    private lazy var ladderButton = getButton(icon: "trophy.fill", tag: 2, action: action)
    private lazy var analyticsButton = getButton(icon: "align.vertical.bottom.fill", tag: 3, action: action)

    //TabBar Buttons Titles
    private lazy var houseTitle = getTitle(text: "Overview", tag: 0, textColor: selected)
    private lazy var ladderTitle = getTitle(text: "Ladder", tag: 2)
    private lazy var analyticsTitle = getTitle(text: "Analytics", tag: 3)

    //TabBar Elements
    private lazy var houseElement = getTabBarElement(buttons: houseButton, title: houseTitle)
    private lazy var ladderElement = getTabBarElement(buttons: ladderButton, title: ladderTitle)
    private lazy var analyticsElement = getTabBarElement(buttons: analyticsButton, title: analyticsTitle)

    private lazy var tabBarSecondView: UIView = {
        $0.backgroundColor = main
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private lazy var customBar: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = main
        $0.layer.cornerRadius = 22
        $0.layer.zPosition = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true

        $0.addArrangedSubview(houseElement)
        $0.addArrangedSubview(ladderElement)
        $0.addArrangedSubview(analyticsElement)
        return $0
    }(UIStackView())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    private func configureViewControllers() {
        view.addSubview(customBar)
        view.addSubview(tabBarSecondView)
        tabBar.isHidden = true

        playerNavBarController.tabBarItem = UITabBarItem(title: "Overview", image: nil, tag: 0)

        ladderNavBarController.tabBarItem = UITabBarItem(title: "Ladder", image: nil, tag: 2)
        analyticsNavBarController.tabBarItem = UITabBarItem(title: "Analytics", image: nil, tag: 3)

        setViewControllers([playerNavBarController,
                            ladderNavBarController,
                            analyticsNavBarController], animated: false)

        NSLayoutConstraint.activate([
            customBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            customBar.heightAnchor.constraint(equalToConstant: 74),

            tabBarSecondView.topAnchor.constraint(equalTo: customBar.bottomAnchor, constant: -25),
            tabBarSecondView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: +25),
            tabBarSecondView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarSecondView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    //Buttons Action
    lazy var action = UIAction { [weak self] sender in
        guard let sender = sender.sender as? UIButton,
              let self = self
        else { return }

        self.selectedIndex = sender.tag
        self.setButtonColor(tag: sender.tag)
        self.setTitleColor(tag: sender.tag)
    }

    private func setButtonColor(tag: Int) {
        [houseButton, ladderButton, analyticsButton,].forEach { button in
            if button.tag != tag {
                button.tintColor = nonSelected
            } else {
                button.tintColor = selected
            }
        }
    }

    private func setTitleColor(tag: Int) {
        [houseTitle, ladderTitle, analyticsTitle,].forEach { title in
            if title.tag != tag {
                title.textColor = nonSelected
            } else {
                title.textColor = selected
            }
        }
    }
}
