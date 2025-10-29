//
//  DetailViewController.swift
//  Dota2Tracker
//
//  Created by Михаил Кушаков on 29.10.2025.
//

import UIKit

final class DetailViewController: UIViewController {

    deinit {
        print("DetailViewController deinit")
    }

    var data: Players?

    private lazy var bg: GradientBackgrounView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(GradientBackgrounView())

    private let avatarImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private let nameLabel: UILabel = {
            let label = UILabel()
            label.text = "Strader"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            return label
        }()

        private let winsLabel: UILabel = {
            let label = UILabel()
            label.text = "WINS 2608"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()

        private let lossesLabel: UILabel = {
            let label = UILabel()
            label.text = "LOSS 2771"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()

        private let winRateLabel: UILabel = {
            let label = UILabel()
            label.text = "WIN RATE 48.5%"
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 14)
            return label
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Palette.TabBar.selectedItemColor
        title = "инфа игрока"
        setupData(data: data)
        setupView()
        setupLayoutTableView()
        setupLayout()
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    private func setupData(data: Players?) {
        if let data = data {
            title = data.name
            avatarImageView.image = UIImage(named: data.avatar)
            nameLabel.text = data.name
            winsLabel.text = "WINS \(data.wins)"
            lossesLabel.text = "LOSSES \(data.loss)"
            winRateLabel.text = "WIN RATE \(data.winrate)"
        } else {
            return
        }
    }

    private func setupView() {
        view.addSubview(bg)
        view.addSubview(avatarImageView)
    }

    private func setupLayoutTableView() {
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: view.topAnchor),
            bg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupLayout() {
            let stackView = UIStackView(arrangedSubviews: [
                nameLabel,
                winsLabel,
                lossesLabel,
                winRateLabel,
            ])

            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.alignment = .leading
            stackView.distribution = .fill

            view.addSubview(stackView)

            stackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
                avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                avatarImageView.heightAnchor.constraint(equalToConstant: 200),
                avatarImageView.widthAnchor.constraint(equalToConstant: 200),

                stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
                stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ])
        }
}
