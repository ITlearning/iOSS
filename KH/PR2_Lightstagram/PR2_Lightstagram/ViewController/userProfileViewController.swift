//
//  userProfileViewController.swift
//  PR2_Lightstagram
//
//  Created by ROLF J. on 2022/06/14.
//

import UIKit
import SnapKit
import CoreData

class userProfileViewController: UIViewController {
    
    var mainFeedButton = UIButton()
    var feedAddEditButton = UIButton()
    var userProfileButton = UIButton()
    
    // Add/Edit ViewController로 넘어가는 함수. 우선 automatic으로.
    @objc func clickAEB(_ sender: UIButton) {
        let addEditVC = addEditViewController()
        addEditVC.modalPresentationStyle = .automatic
        self.present(addEditVC, animated: true)
    }
    
    @objc func clickmainB(_ sender: UIButton) {
        let mainVC = mainViewController()
        mainVC.modalPresentationStyle = .fullScreen
        self.present(mainVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // 화면 흰색으로 변경
        view.backgroundColor = .white
        
        // Username
        let userName = UILabel()
        userName.text = "JKH"
        userName.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.view.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.width.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
        // User Information
        
        // User Image
        let userProfileImage = UIImageView()
        userProfileImage.image = #imageLiteral(resourceName: "IMG_3117.JPG")
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.cornerRadius = 40
        self.view.addSubview(userProfileImage)
        userProfileImage.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.height.equalTo(80)
        }
        
        // Number of feeds
        let feedCount = UILabel()
        feedCount.text = "1K"
        self.view.addSubview(feedCount)
        feedCount.snp.makeConstraints { make in
            make.left.equalTo(userProfileImage.snp.right).offset(40)
            make.centerY.equalTo(userProfileImage.snp.centerY).offset(-10)
        }
        let feedText = UILabel()
        feedText.text = "게시물"
        self.view.addSubview(feedText)
        feedText.snp.makeConstraints { make in
            make.top.equalTo(feedCount.snp.bottom)
            make.centerX.equalTo(feedCount.snp.centerX)
        }
        
        // Number of Follwers
        let followerCount = UILabel()
        followerCount.text = "1M"
        self.view.addSubview(followerCount)
        followerCount.snp.makeConstraints { make in
            make.left.equalTo(feedCount.snp.right).offset(65)
            make.centerY.equalTo(userProfileImage.snp.centerY).offset(-10)
        }
        let followerText = UILabel()
        followerText.text = "팔로워"
        self.view.addSubview(followerText)
        followerText.snp.makeConstraints { make in
            make.top.equalTo(followerCount.snp.bottom)
            make.centerX.equalTo(followerCount.snp.centerX)
        }
        
        // Number of Follwing
        let followingCount = UILabel()
        followingCount.text = "1M"
        self.view.addSubview(followingCount)
        followingCount.snp.makeConstraints { make in
            make.left.equalTo(followerCount.snp.right).offset(65)
            make.centerY.equalTo(userProfileImage.snp.centerY).offset(-10)
        }
        let followingText = UILabel()
        followingText.text = "팔로워"
        self.view.addSubview(followingText)
        followingText.snp.makeConstraints { make in
            make.top.equalTo(followingCount.snp.bottom)
            make.centerX.equalTo(followingCount.snp.centerX)
        }
        
        // User Nickname
        let userNickname = UILabel()
        userNickname.text = "장경호"
        userNickname.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.view.addSubview(userNickname)
        userNickname.snp.makeConstraints { make in
            make.top.equalTo(userProfileImage.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        // Subtitle/Content
        let userIntroduction = UILabel()
        userIntroduction.font = UIFont.systemFont(ofSize: 15.0)
        userIntroduction.text = "인스타그램 경량화 버전입니다 만들기 드릅게 힘드네요"
        self.view.addSubview(userIntroduction)
        userIntroduction.snp.makeConstraints { make in
            make.top.equalTo(userNickname.snp.bottom)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        // Set profile button
        let setProfileButton = UIButton()
        setProfileButton.backgroundColor = .white
        setProfileButton.setTitle("프로필 편집", for: .normal)
        setProfileButton.layer.cornerRadius = 5
        setProfileButton.layer.borderWidth = 1.0
        setProfileButton.layer.borderColor = UIColor.lightGray.cgColor
        setProfileButton.setTitleColor(.black, for: .normal)
        self.view.addSubview(setProfileButton)
        setProfileButton.snp.makeConstraints { make in
            make.top.equalTo(userIntroduction.snp.bottom).offset(10)
            make.centerX.equalTo(self.view)
            make.width.equalTo(370)
            make.height.equalTo(40)
        }
        
        // Feed/People 버튼이 들어갈 UIView
        let feedPeopleView = UIView()
        feedPeopleView.layer.borderWidth = 1.0
        feedPeopleView.layer.borderColor = UIColor.lightGray.cgColor
        self.view.addSubview(feedPeopleView)
        feedPeopleView.snp.makeConstraints { make in
            make.top.equalTo(setProfileButton.snp.bottom).offset(10)
            make.width.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        // Feed Button
        let userFeedButton = UIButton()
        var UFConfig = UIButton.Configuration.plain()
        UFConfig.image = UIImage(systemName: "squareshape.split.3x3")
        userFeedButton.configuration = UFConfig
        userFeedButton.setTitle("Feed", for: .normal)
        self.view.addSubview(userFeedButton)
        userFeedButton.snp.makeConstraints { make in
            make.centerY.equalTo(feedPeopleView.snp.centerY)
            make.centerX.equalTo(feedPeopleView.snp.centerX).offset(-100)
        }
        
        // People Button
        let peopleButton = UIButton()
        var PPConfig = UIButton.Configuration.plain()
        PPConfig.subtitle = "People"
        PPConfig.image = UIImage(systemName: "person.crop.square")
        peopleButton.configuration = PPConfig
        self.view.addSubview(peopleButton)
        peopleButton.snp.makeConstraints { make in
            make.centerY.equalTo(feedPeopleView.snp.centerY)
            make.centerX.equalTo(feedPeopleView.snp.centerX).offset(100)
        }
        
        // Over here_User Information
        
        
        
        
        
        // 하단부, 버튼들이 들어갈 공간을 UIView로 설정하고 Background color 지정
        let naviButtonBar = UIView()
        self.view.addSubview(naviButtonBar)
        naviButtonBar.backgroundColor = .lightGray
        naviButtonBar.snp.makeConstraints { make in
            make.width.bottom.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        // mainFeedButton
        var mainConfig = UIButton.Configuration.plain()
        mainConfig.image = UIImage(systemName: "house.fill")
        mainFeedButton.configuration = mainConfig
        mainFeedButton.tintColor = .gray
        self.view.addSubview(mainFeedButton)
        mainFeedButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        mainFeedButton.addTarget(self, action: #selector(clickmainB(_:)), for: .touchUpInside)
        
        // feedAddEditButton
        var addEditConfig = UIButton.Configuration.plain()
        addEditConfig.image = UIImage(systemName: "plus.rectangle")
        feedAddEditButton.configuration = addEditConfig
        feedAddEditButton.tintColor = .green
        self.view.addSubview(feedAddEditButton)
        feedAddEditButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        feedAddEditButton.addTarget(self, action: #selector(clickAEB(_:)), for: .touchUpInside)

        // userProfileButton
        var userConfig = UIButton.Configuration.plain()
        userConfig.image = UIImage(systemName: "person.fill")
        userProfileButton.configuration = userConfig
        self.view.addSubview(userProfileButton)
        userProfileButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
    }
}
