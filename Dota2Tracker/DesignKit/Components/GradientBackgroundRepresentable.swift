//
//  GradientBackgroundRepresentable.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 01.11.2025.
//

import SwiftUI
import UIKit

struct GradientBackgroundRepresentable: UIViewRepresentable {

    func makeUIView(context: Context) -> GradientBackgroundView {
        let view = GradientBackgroundView()
        view.isUserInteractionEnabled = false
        view.contentScaleFactor = UIScreen.main.scale
        return view
    }

    func updateUIView(_ uiView: GradientBackgroundView, context: Context) {
        uiView.setNeedsDisplay()
        uiView.layoutIfNeeded()
    }
}
