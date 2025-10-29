import UIKit

extension UIView {
    func dropShadow(opacity: Float, radius: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = Palette.TabBar.mainColor.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
