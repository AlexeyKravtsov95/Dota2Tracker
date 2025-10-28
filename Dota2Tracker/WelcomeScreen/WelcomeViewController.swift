//
//  WelcomeViewController.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 28.10.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private lazy var bg: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [Palette.Gradient.violetDeep, Palette.Gradient.blueDeep]
        layer.startPoint = CGPoint(x: 0.0, y: 0.0)
        layer.endPoint = CGPoint(x: 1.0, y: 1.0)
        return layer
    }()

    private lazy var anim: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = CGPoint(x: 0.0, y: 0.0)
        animation.toValue = CGPoint(x: 0.15, y: 0.1)
        animation.duration = 6
        animation.autoreverses = true
        animation.repeatCount = .infinity
        return animation
    }()

    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: GradientTextLabel = {
        let label = GradientTextLabel()
        label.text = "Dota 2\nTracker".uppercased()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 44, weight: .bold)
        return label
    }()

    private lazy var textField: UITextField = {
        let textField = UITextField()
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        icon.tintColor = .white.withAlphaComponent(0.85)
        icon.contentMode = .scaleAspectFit
        icon.frame = CGRect(x: 12, y: 9, width: 18, height: 18)
        container.addSubview(icon)
        textField.leftView = container
        textField.attributedPlaceholder = NSAttributedString(
            string: "Никнейм игрока",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.65)])
        textField.backgroundColor = UIColor(white: 1, alpha: 0.12)
        textField.layer.cornerRadius = 14
        textField.textColor = .white
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .search
        return textField
    }()

    private lazy var searchButton: GradientButton = {
        let button = GradientButton()
        button.setTitle("Искать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addAction(UIAction {
            [weak self] _ in
            self?.textField.resignFirstResponder()
            self?.goToFirstTab()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 24
        return stack
    }()

    private let container = UIView()

    override func loadView() {
        super.loadView()

        let view = UIView()
        view.backgroundColor = .white
        view.layer.insertSublayer(bg, at: 0)
        self.view = view
        bg.add(anim, forKey: "parallax")

        [logo, titleLabel, textField, searchButton].forEach {
            stack.addArrangedSubview($0)
        }
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.addSubview(stack)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let margins = view.layoutMarginsGuide
        bg.frame = view.bounds
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 112),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 86),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.leadingAnchor.constraint(greaterThanOrEqualTo: margins.leadingAnchor),
            container.trailingAnchor.constraint(lessThanOrEqualTo: margins.trailingAnchor),
            container.widthAnchor.constraint(lessThanOrEqualToConstant: 520),

            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            stack.topAnchor.constraint(equalTo: container.topAnchor),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            textField.widthAnchor.constraint(equalTo: container.widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 56),
            searchButton.widthAnchor.constraint(equalTo: container.widthAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    private func goToFirstTab() {
        let tabBarController = TabBarController()
        if let window = view.window?.windowScene?.windows.first {
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = tabBarController
            }, completion: nil)
        }
    }
}
