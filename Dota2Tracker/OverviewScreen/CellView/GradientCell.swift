//
//  GradientCell.swift
//  Dota2Tracker
//
//  Created by Михаил Кушаков on 29.10.2025.
//
import UIKit

final class GradientCellView: UIView {
    private var gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        layer.cornerRadius = 16
        layer.masksToBounds = true
        gradientLayer.colors = [
            Palette.Gradient.purple,
            Palette.Gradient.purpleDeep
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
    }
}
