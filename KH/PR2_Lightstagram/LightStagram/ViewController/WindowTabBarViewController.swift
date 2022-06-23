//
//  WindowTabBarViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit

class WindowTabBarController: UITabBarController {
    
    let firstViewController = UINavigationController(rootViewController: MainViewController())
    let secondViewController = UINavigationController(rootViewController: AddEditViewController())
    let thirdViewController = UINavigationController(rootViewController: UserProfileViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBarLayout()
        
        // tabBar의 모양
        tabBar.backgroundColor = .systemGray3
        tabBar.tintColor = .blue
        tabBar.unselectedItemTintColor = .systemGray
    }

    // 탭바로 ViewController들을 이동할 수 있도록 링크 생성
    private func setUpTabBarLayout() {
        firstViewController.tabBarItem.image = UIImage(systemName: "house")
        secondViewController.tabBarItem.image = UIImage(systemName: "plus.rectangle")
        thirdViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        viewControllers = [firstViewController, secondViewController, thirdViewController]
    }
}
