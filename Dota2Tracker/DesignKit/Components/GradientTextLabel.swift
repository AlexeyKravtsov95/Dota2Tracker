//
//  GradientTextLabel.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 28.10.2025.
//

import UIKit

final class GradientTextLabel: UIView {
    private let gradient = CAGradientLayer()
    private let label = CATextLayer()

    var text: String? { didSet { updateMaskString(); invalidateIntrinsicContentSize(); setNeedsLayout() } }
    var font: UIFont = .systemFont(ofSize: 44, weight: .bold) { didSet { updateMaskFont(); invalidateIntrinsicContentSize(); setNeedsLayout() } }
    var textAlignment: NSTextAlignment = .left { didSet { updateMaskAlignment() } }
    var numberOfLines: Int = 0 { didSet { label.isWrapped = numberOfLines != 1; setNeedsLayout() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = true


        gradient.colors = [
            Palette.Gradient.purple,
            Palette.Gradient.purpleDeep
        ]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        layer.addSublayer(gradient)
        label.contentsScale = UIScreen.main.scale
        label.isWrapped = true
        label.truncationMode = .none
        updateMaskFont()
        updateMaskAlignment()
        updateMaskString()
        gradient.mask = label
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
        label.frame = bounds
    }

    override var intrinsicContentSize: CGSize {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        style.lineBreakMode = .byWordWrapping
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .paragraphStyle: style]
        let rect = (text ?? "").boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attrs, context: nil)
        return CGSize(width: ceil(rect.width), height: ceil(rect.height))
    }

    private func updateMaskString() {
        label.string = text as NSString?
    }

    private func updateMaskFont() {
        label.font = font
        label.fontSize = font.pointSize
    }

    private func updateMaskAlignment() {
        switch textAlignment {
        case .center:
            label.alignmentMode = .center
        case .right:
            label.alignmentMode = .right
        default:
            label.alignmentMode = .left
        }
    }

}
