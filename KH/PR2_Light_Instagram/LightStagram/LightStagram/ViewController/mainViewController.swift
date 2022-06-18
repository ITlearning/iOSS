//
//  ViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/16.
//

import UIKit

class mainViewController: UIViewController {
    
    @IBOutlet weak var feedTable: UITableView!
    
    @IBAction func clickAEVCB() {
        guard let addEditVC = storyboard?.instantiateViewController(withIdentifier: "addEdit") else { return }
        addEditVC.modalPresentationStyle = .fullScreen
        addEditVC.modalTransitionStyle = .coverVertical
        self.present(addEditVC, animated: true, completion: nil)
    }
    
    @IBAction func clickUPVC() {
        guard let userProfileVC = storyboard?.instantiateViewController(withIdentifier: "userProfile") else { return }
        userProfileVC.modalPresentationStyle = .fullScreen
        userProfileVC.modalTransitionStyle = .coverVertical
        self.present(userProfileVC, animated: true, completion: nil)
        }

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.feedTable.delegate = self
//        self.feedTable.dataSource = self
        
    }

}

extension mainViewController: UITableViewDelegate {
    
}

//extension mainViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath)
//        let feed = self.
//    }
//
//
//}
