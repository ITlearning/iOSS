//
//  WindowTabBarViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit

class WindowTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarLayout()
    }

    // 탭바로 ViewController들을 이동할 수 있도록 링크 생성
    private func setUpTabBarLayout() {
        let firstViewController = UINavigationController(rootViewController: MainViewController())
        let secondViewController = UINavigationController(rootViewController: AddEditViewController())
        let thirdViewController = UINavigationController(rootViewController: UserProfileViewController())
        
        firstViewController.tabBarItem.image = UIImage(systemName: "house")
        secondViewController.tabBarItem.image = UIImage(systemName: "plus.rectangle")
        thirdViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        tabBar.backgroundColor = .systemGray3
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .systemGray
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
