import UIKit

extension TabBarController {

    // MARK: - Создание кнопки
    func getButton(icon: String, tag: Int, action: UIAction, tintColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UIButton {
        return {
            $0.setImage(UIImage(systemName: icon), for: .normal)
            $0.tintColor = tintColor
            $0.tag = tag
            return $0
        }(UIButton(primaryAction: action))
    }

    // MARK: - Создание тайтла
    func getTitle(text: String, tag: Int, textColor: UIColor = #colorLiteral(red: 0.3128828704, green: 0.3234004974, blue: 0.4565579295, alpha: 1)) -> UILabel {
        return {
            $0.text = text
            $0.textAlignment = .center
            $0.textColor = textColor
            $0.font = .systemFont(ofSize: 10)
            $0.tag = tag
            return $0
        }(UILabel())
    }

    // MARK: - Создание Кнопки и татйла
    func getTabBarElement(buttons: UIButton, title: UILabel) -> UIStackView {
        return {
            $0.axis = .vertical
            $0.alignment = .center
            $0.spacing = 3
            return $0
        }(UIStackView(arrangedSubviews: [buttons, title]))
    }
}
