import UIKit

final class SplashAnimator {
    static func addScalingAnimation(to layer: CALayer, duration: TimeInterval) {
        let animation = CABasicAnimation()

        let tangent = layer.position.y / layer.position.x
        let angel = atan(tangent)

        animation.beginTime = CACurrentMediaTime()
        animation.duration = duration
        animation.valueFunction = CAValueFunction(name: .rotateZ)
        animation.fromValue = 0
        animation.toValue = angel
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        layer.add(animation, forKey: "transform")
    }

    static func addRotationAnimation(to layer: CALayer, duration: TimeInterval) {
        let animation = CAKeyframeAnimation(keyPath: "bounds")
        let width = layer.frame.width
        let height = layer.frame.height
        let coef: CGFloat = 18 / 400
        let finalScale = coef * UIScreen.main.bounds.height
        let scales: [CGFloat] = [1, 0.85, finalScale]

        animation.beginTime = CACurrentMediaTime()
        animation.duration = duration
        animation.values = scales.map { NSValue(cgRect: CGRect(x:0, y:0, width: width * $0, height: height * $0))}
        animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut),
                                     CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards

        layer.add(animation, forKey: "bounds")
    }
}
