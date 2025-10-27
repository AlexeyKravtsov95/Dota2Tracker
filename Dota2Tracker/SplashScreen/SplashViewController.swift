import UIKit

final class SplashViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }

    lazy var logoImageView = {
        $0.image = UIImage(named: "appLogo")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }

    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(logoImageView)
    }

    private func setupLayout() {
        NSLayoutConstraint
            .activate([
                logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                logoImageView.widthAnchor.constraint(equalToConstant: 72),
                logoImageView.heightAnchor.constraint(equalToConstant: 72)
            ])
    }
}
