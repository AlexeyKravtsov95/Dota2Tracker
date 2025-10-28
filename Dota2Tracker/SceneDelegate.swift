//
//  SceneDelegate.swift
//  Dota2Tracker
//
//  Created by Алексей Кравцов on 27.10.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let splashViewController = SplashViewController()

        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        window?.rootViewController = splashViewController

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.window?.rootViewController = TabBarController()
            let mask = CALayer()
            mask.frame = splashViewController.logoImageView.frame
            mask.contents = UIImage(named: "appLogo")?.cgImage
            self.window?.layer.mask = mask

            SplashAnimator.addScalingAnimation(to: mask, duration: 0.5)
            SplashAnimator.addRotationAnimation(to: mask, duration: 0.5)
        }
    }
}

