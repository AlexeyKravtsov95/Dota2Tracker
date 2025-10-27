//
//  GradientButton.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 28.10.2025.
//

import UIKit

final class GradientButton: UIButton {
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
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        gradientLayer.colors = [
            Palette.Gradient.indigo,
            Palette.Gradient.purpleIndigo
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
