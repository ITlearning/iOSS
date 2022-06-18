//
//  userProfileViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/16.
//

import UIKit

class userProfileViewController: UIViewController {
    
    @IBOutlet var userProfileImage: UIImageView!
    var UFImage: UIImage?
    
    @IBAction func profileEditButton() {
        let alert = UIAlertController(title: "프로필 편집", message: "준비중입니다.", preferredStyle: .alert)
        
        let checkButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(checkButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func feedButton() {
        let alert = UIAlertController(title: "Feed", message: "준비중입니다.", preferredStyle: .alert)
        
        let checkButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(checkButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func peopleButton() {
        let alert = UIAlertController(title: "People", message: "준비중입니다.", preferredStyle: .alert)
        
        let checkButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(checkButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clickAEVCB() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "addEdit") else { return }
        addEditVC.modalPresentationStyle = .fullScreen
        addEditVC.modalTransitionStyle = .coverVertical
        self.present(addEditVC, animated: true, completion: nil)
    }
    
    @IBAction func clickMVCB() {
        guard let MVC = storyboard?.instantiateViewController(withIdentifier: "main") else { return }
        navigationController?.pushViewController(MVC, animated: true)
        MVC.modalPresentationStyle = .fullScreen
        MVC.modalTransitionStyle = .coverVertical
        self.present(MVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UFImage = UIImage(named: "277030F1-A3E3-4EBC-AE09-C4C03BE158B3")
        userProfileImage.image = UFImage
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.width/1.9
        
        
    }
    
}
