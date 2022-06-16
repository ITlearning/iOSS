// SceneDelegate.swift

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        let tab = UITabBarController()
        tab.view.backgroundColor = .white
        self.window?.rootViewController = tab
        
        let view01 = ViewController()
        let view02 = AddViewController()
        let view03 = UserViewController()
        
        tab.setViewControllers([view01, view02, view03], animated: false)
        
        view01.tabBarItem = UITabBarItem(title: "Main", image: UIImage(named:"photo"), tag: 1)
        view02.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named:"calender"), tag: 2)
        view03.tabBarItem = UITabBarItem(title: "User", image: UIImage(named:"twitter@2x"), tag: 3)
    }
}
