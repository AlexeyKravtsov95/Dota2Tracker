import UIKit

final class PlayerViewController: UIViewController {

    lazy var playerImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "ava1")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    lazy var bgImageView: GradientBackgroundView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(GradientBackgroundView())

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        playerImageView.layer.cornerRadius = playerImageView.frame.size.width / 2
    }

    private func setupView() {
        view.addSubview(bgImageView)
        view.addSubview(playerImageView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            playerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            playerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playerImageView.heightAnchor.constraint(equalToConstant: 200),
            playerImageView.widthAnchor.constraint(equalToConstant: 200),

            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
