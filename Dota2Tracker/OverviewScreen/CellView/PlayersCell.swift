import UIKit

final class PlayersCell: UITableViewCell {

    static var reuseId: String = "PlayersCell"

    private lazy var cellView: GradientCellView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(GradientCellView())

    private lazy var cellNameLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    private lazy var cellStatusLabel: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    lazy var avatarImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 23
        $0.backgroundColor = .systemGray3
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())

    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .leading
        $0.distribution = .equalCentering
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func viewWillAppear(_ animated: Bool) {
//        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
//    }

    func setupCell(data: Player) {
        cellNameLabel.text = data.personaName

        if let url = URL(string: data.avatarFull) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, error == nil, let imageData = data else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: imageData)
                }
            }.resume()
        }

        if data.isOnline {
            cellStatusLabel.text = "ONLINE"
        } else {
            cellStatusLabel.text = "OFFLINE"
        }

        addSubview(cellView)
        cellView.addSubview(stackView)
        cellView.addSubview(avatarImageView)
        stackView.addArrangedSubview(cellNameLabel)
        stackView.addArrangedSubview(cellStatusLabel)

        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),

            avatarImageView.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 46),
            avatarImageView.widthAnchor.constraint(equalToConstant: 46),
            avatarImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),

            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
        ])
    }
}
