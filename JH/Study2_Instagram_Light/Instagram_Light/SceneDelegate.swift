// SceneDelegate.swift

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        let tab = UITabBarController()
        tab.view.backgroundColor = .systemGray2
        self.window?.rootViewController = tab
        
        let view01 = MainViewController()
        let view02 = AddViewController()
        let view03 = UserViewController()
        
        tab.setViewControllers([view01, view02, view03], animated: false)
        
        tab.tabBar.backgroundColor = .systemGray4
        
//        view01.tabBarItem.title = "home"
//        view02.tabBarItem.title = "Add"
//        view03.tabBarItem.title = "Main"
        
        view01.tabBarItem.image = UIImage.init(systemName: "house")
        view02.tabBarItem.image = UIImage.init(systemName: "plus.rectangle")
        view03.tabBarItem.image = UIImage.init(systemName: "person.fill")
    }
}
