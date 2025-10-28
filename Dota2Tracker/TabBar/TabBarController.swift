import UIKit

final class TabBarController: UITabBarController {
    private let mainColor = #colorLiteral(red: 0.2017591894, green: 0.2275671363, blue: 0.5467777252, alpha: 1)
    private let secondColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)
    private let tabBarColor = #colorLiteral(red: 0.06141165644, green: 0.06498453766, blue: 0.1378280222, alpha: 1)

    //App Controllers
    let welcomeTabController = WelcomeViewController()
    let liveTabController = LiveViewController()
    let ladderTabController = LadderViewController()
    let analyticsTabController = AnalyticsViewController()

    //TabBar Buttons
    private lazy var houseButton = getButton(icon: "house.fill", tag: 0, action: action, tintColor: mainColor)
    private lazy var liveButton = getButton(icon: "play.fill", tag: 1, action: action)
    private lazy var ladderButton = getButton(icon: "trophy.fill", tag: 2, action: action)
    private lazy var analyticsButton = getButton(icon: "align.vertical.bottom.fill", tag: 3, action: action)

    //TabBar Buttons Titles
    private lazy var houseTitle = getTitle(text: "OverView", tag: 0, textColor: mainColor)
    private lazy var liveTitle = getTitle(text: "Live", tag: 1)
    private lazy var ladderTitle = getTitle(text: "Ladder", tag: 2)
    private lazy var analyticsTitle = getTitle(text: "Analytics", tag: 3)

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

        welcomeTabNavController.tabBarItem = UITabBarItem(title: "Overview", image: nil, tag: 0)
        liveTabNavController.tabBarItem = UITabBarItem(title: "Live", image: nil, tag: 1)
        ladderTabNavController.tabBarItem = UITabBarItem(title: "Ladder", image: nil, tag: 2)
        analyticsTabNavController.tabBarItem = UITabBarItem(title: "Analytics", image: nil, tag: 3)

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

    private func getButton(icon: String, tag: Int, action: UIAction, tintColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UIButton {
        return {
            $0.setImage(UIImage(systemName: icon), for: .normal)
            $0.tintColor = tintColor
            $0.tag = tag
            return $0
        }(UIButton(primaryAction: action))
    }

    private func getTitle(text: String, tag: Int, textColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UILabel {
        return {
            $0.text = text
            $0.textAlignment = .center
            $0.textColor = textColor
            $0.font = .systemFont(ofSize: 10)
            $0.tag = tag
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
