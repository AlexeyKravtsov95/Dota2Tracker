import UIKit

class CustomNavBar: UIView {

    private lazy var titleLabel: GradientTextLabel = {
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.text = "Игроки"
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(GradientTextLabel())

    private lazy var searchButton: GradientButton = {
        $0.setTitle("Искать", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.layer.cornerRadius = 10
        $0.dropShadow(opacity: 0.3, radius: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addAction(UIAction {
            [weak self] _ in
            self?.goToSearch()
        }, for: .touchUpInside)
        return $0
    }(GradientButton())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(searchButton)
        setUpLayout()
    }

    private func setUpLayout() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            searchButton.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

    private func goToSearch() {
        let welcomeViewController = WelcomeViewController()
        if let window = window?.windowScene?.windows.first {
            window.rootViewController = welcomeViewController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = welcomeViewController
            }, completion: nil)
        }
    }
}
