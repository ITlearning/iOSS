//
//  ViewController.swift
//  LightInstagram
//
//  Created by ROLF J. on 2022/05/23.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    
    // Main 화면 피드를 보여줄 TableView
    let feedTableView = UITableView()
    
    // 하단에 들어갈 버튼 선언
    var mainFeedButton = UIButton()
    var feedAddButton = UIButton()
    var userProfileButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main 화면 배경색 설정
        view.backgroundColor = .white
        
        // Main 화면(피드 화면)의 제목(TextLabel)
        let userViewTitle = UILabel()
        userViewTitle.text = "   Lightstagram"
        userViewTitle.backgroundColor = .orange
        self.view.addSubview(userViewTitle)
        userViewTitle.font = UIFont.boldSystemFont(ofSize: 30.0)
        userViewTitle.snp.makeConstraints { make in
            make.width.left.equalTo(self.view)
            make.height.equalTo(70)
            make.top.equalTo(self.view).offset(40)
        }
        
        // 모든 화면에 들어갈 하단부 Navigation Bar, 버튼이 들어갈 공간의 Background color 지정
        let naviButtonBar = UIView()
        self.view.addSubview(naviButtonBar)
        naviButtonBar.backgroundColor = .lightGray
        naviButtonBar.snp.makeConstraints { make in
            make.width.bottom.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        // feed들을 보여줄 tableView 공간 설정
        self.view.addSubview(feedTableView)
        feedTableView.backgroundColor = .gray
        feedTableView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.top.equalTo(userViewTitle.snp.bottom)
            make.bottom.equalTo(naviButtonBar.snp.top)
        }
        
        // mainFeedButton
        mainFeedButton.backgroundColor = .blue
        self.view.addSubview(mainFeedButton)
        mainFeedButton.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.height.equalTo(30)
        }
        
        // feedAddButton
        feedAddButton.backgroundColor = .red
        self.view.addSubview(feedAddButton)
        feedAddButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.height.equalTo(30)
        }
        
        // userProfileButton
        userProfileButton.backgroundColor = .green
        self.view.addSubview(userProfileButton)
        userProfileButton.snp.makeConstraints { make in
            make.right.equalTo(self.view).offset(-80)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.height.equalTo(30)
        }
        
        
        // Main 화면의 FeedCell 위치 설정
//        let LSFeedCell
        
//        let userImage = UIImage()
//        self.view.addSubview(userImage)
//        userImage.snp.makeConstraints { (make) in
//            make.top.equalTo(userViewTitle).offset(30)
//        }
        
    }
}

//extension FeedViewController: UITableViewDelegate {
//
//}
//
//extension FeedViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//
//
//}
