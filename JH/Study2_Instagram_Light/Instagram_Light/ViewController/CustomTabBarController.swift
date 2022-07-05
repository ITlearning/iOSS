//
//  CustomTabBarController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/24.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {
    let addViewControllerNavigationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
    }
    
    func configureLayout() {
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .gray
        self.tabBar.backgroundColor = UIColor.backgroundColor
        
        let firstViewController = MainViewController()
        
        firstViewController.view.backgroundColor = UIColor.backgroundColor
        firstViewController.tabBarItem.selectedImage = UIImage(systemName: "house")
        firstViewController.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let secondViewController = UserViewController()
        
        secondViewController.view.backgroundColor = UIColor.backgroundColor
        secondViewController.tabBarItem.selectedImage = UIImage(systemName: "person")
        secondViewController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        viewControllers = [firstViewController, secondViewController]
        
        addViewControllerNavigationButton.setImage(UIImage(systemName: "plus.rectangle"), for: .normal)
        addViewControllerNavigationButton.tintColor = .gray
        
        view.addSubview(addViewControllerNavigationButton)
        
        addViewControllerNavigationButton.contentVerticalAlignment = .fill
        addViewControllerNavigationButton.contentHorizontalAlignment = .fill
    
        addViewControllerNavigationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(180)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    
        addViewControllerNavigationButton.addTarget(addViewControllerNavigationButtonAction(_:), action: #selector(addViewControllerNavigationButtonAction), for: .touchUpInside)
    }
    
    @objc func addViewControllerNavigationButtonAction(_ sender: UIButton) {
        let myViewController = AddViewController()
        myViewController.modalPresentationStyle = .fullScreen
        present(myViewController, animated: true, completion: nil)
    }
}
