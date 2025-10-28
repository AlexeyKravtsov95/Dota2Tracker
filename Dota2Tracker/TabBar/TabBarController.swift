import UIKit

enum Tabs: Int {
    case first
    case second
    case third
    case fourth
    case fifth
}

final class TabBarController: UITabBarController {
    private let mainColor = #colorLiteral(red: 0.2017591894, green: 0.2275671363, blue: 0.5467777252, alpha: 1)
    private let secondColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)
    private let tabBarColor = #colorLiteral(red: 0.06141165644, green: 0.06498453766, blue: 0.1378280222, alpha: 1)

    //App Controllers
    let welcomeTabNavController = UINavigationController(rootViewController: WelcomeViewController())
    let liveTabNavController = UINavigationController(rootViewController: LiveViewController())
    let ladderTabNavController = UINavigationController(rootViewController: LadderViewController())
    let analyticsTabNavController = UINavigationController(rootViewController: AnalyticsViewController())

    //TabBar Buttons
    private lazy var houseButton = getButton(icon: "house.fill", tag: .first, action: action, tintColor: mainColor)
    private lazy var liveButton = getButton(icon: "play.fill", tag: .second, action: action)
    private lazy var ladderButton = getButton(icon: "trophy.fill", tag: .third, action: action)
    private lazy var analyticsButton = getButton(icon: "align.vertical.bottom.fill", tag: .fourth, action: action)

    //TabBar Buttons Titles
    private lazy var houseTitle = getTitle(text: "OverView", tag: .first, textColor: mainColor)
    private lazy var liveTitle = getTitle(text: "Live", tag: .second)
    private lazy var ladderTitle = getTitle(text: "Ladder", tag: .third)
    private lazy var analyticsTitle = getTitle(text: "Analytics", tag: .fourth)

    //TabBar Elements
    private lazy var houseElement = getTabBarElement(buttons: houseButton, title: houseTitle)
    private lazy var liveElement = getTabBarElement(buttons: liveButton, title: liveTitle)
    private lazy var ladderElement = getTabBarElement(buttons: ladderButton, title: ladderTitle)
    private lazy var analyticsElement = getTabBarElement(buttons: analyticsButton, title: analyticsTitle)

    private lazy var tabBarSecondView: UIView = {
        $0.backgroundColor = tabBarColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private lazy var customBar: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = tabBarColor
        $0.layer.cornerRadius = 22
        $0.layer.zPosition = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        $0.isLayoutMarginsRelativeArrangement = true

        $0.addArrangedSubview(houseElement)
        $0.addArrangedSubview(liveElement)
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

        welcomeTabNavController.tabBarItem = UITabBarItem(title: "Overview", image: nil, tag: Tabs.first.rawValue)
        liveTabNavController.tabBarItem = UITabBarItem(title: "Live", image: nil, tag: Tabs.second.rawValue)
        ladderTabNavController.tabBarItem = UITabBarItem(title: "Ladder", image: nil, tag: Tabs.third.rawValue)
        analyticsTabNavController.tabBarItem = UITabBarItem(title: "Analytics", image: nil, tag: Tabs.fourth.rawValue)

        setViewControllers([welcomeTabNavController,
                            liveTabNavController,
                            ladderTabNavController,
                            analyticsTabNavController], animated: false)

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

    private func getButton(icon: String, tag: Tabs, action: UIAction, tintColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UIButton {
        return {
            $0.setImage(UIImage(systemName: icon), for: .normal)
            $0.tintColor = tintColor
            $0.tag = tag.rawValue
            return $0
        }(UIButton(primaryAction: action))
    }

    private func getTitle(text: String, tag: Tabs, textColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UILabel {
        return {
            $0.text = text
            $0.textAlignment = .center
            $0.textColor = textColor
            $0.font = .systemFont(ofSize: 10)
            $0.tag = tag.rawValue
            return $0
        }(UILabel())
    }

    private func getTabBarElement(buttons: UIButton, title: UILabel) -> UIStackView {
        return {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 3
            return $0
        }(UIStackView(arrangedSubviews: [buttons, title]))
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
        [houseButton, liveButton, ladderButton, analyticsButton,].forEach { button in
            if button.tag != tag {
                button.tintColor = secondColor
            } else {
                button.tintColor = mainColor
            }
        }
    }

    private func setTitleColor(tag: Int) {
        [houseTitle, liveTitle, ladderTitle, analyticsTitle,].forEach { title in
            if title.tag != tag {
                title.textColor = secondColor
            } else {
                title.textColor = mainColor
            }
        }
    }
}
