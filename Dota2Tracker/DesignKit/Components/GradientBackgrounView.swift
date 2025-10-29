//
//  GradientBackgrounView.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 28.10.2025.
//

import UIKit

final class GradientBackgrounView: UIView {

    private let base = CAGradientLayer()
    private let firstSpot = CAGradientLayer()
    private let secondSpot = CAGradientLayer()
    private let thirdSpot = CAGradientLayer()
    private let vignette = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        setupBase()
        setupSpot(firstSpot, tint: UIColor(cgColor: Palette.Gradient.purpleDeep), alpha: 0.12, radius: 0.5)
        setupSpot(secondSpot, tint: UIColor(cgColor: Palette.Gradient.indigo), alpha: 0.1, radius: 0.7)
        setupSpot(thirdSpot, tint: UIColor(cgColor: Palette.Gradient.purpleIndigo), alpha: 0.16, radius: 0.85)
        layer.addSublayer(base)
        [firstSpot, secondSpot, thirdSpot].forEach { layer.addSublayer($0) }
        setupVignette()
        layer.addSublayer(vignette)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBase() {
        base.colors = [Palette.Gradient.violetDeep, Palette.Gradient.blueDeep]
        base.startPoint = CGPoint(x: 0, y: 0)
        base.endPoint = CGPoint(x: 1, y: 0)
    }

    private func setupSpot(_ gradient: CAGradientLayer, tint: UIColor, alpha: CGFloat, radius: CGFloat) {
        gradient.type = .radial
        gradient.colors = [tint.withAlphaComponent(alpha).cgColor, UIColor.clear.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: radius, y: radius)
        gradient.compositingFilter = "softLightBlendMode"
    }

    private func setupVignette() {
        vignette.type = .radial

        vignette.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.35).cgColor]
        vignette.locations = [0.65, 1]
        vignette.startPoint = CGPoint(x: 0.5, y: 0.5)
        vignette.endPoint = CGPoint(x: 1.0, y: 1)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        base.frame = bounds
        let width = bounds.width
        let height = bounds.height
        let large = CGRect(x: 0, y: 0, width: width * 1.8, height: height * 1.8)
        firstSpot.frame = large
        secondSpot.frame = large
        thirdSpot.frame = large
        firstSpot.position = CGPoint(x: width * 0.3, y: height * 0.35)
        secondSpot.position = CGPoint(x: width * 0.7, y: height * 0.55)
        thirdSpot.position = CGPoint(x: width * 0.5, y: height * 0.8)

        vignette.frame = CGRect(x: -width * 0.2, y: -height * 0.2, width: width * 1.4, height: height * 1.4)
        vignette.position = CGPoint(x: width * 0.5, y: height * 0.5)

    }
}
