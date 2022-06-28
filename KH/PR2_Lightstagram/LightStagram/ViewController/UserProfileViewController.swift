//
//  UserProfileViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit
import SnapKit

class UserProfileViewController: UIViewController {
    
    let feedCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UserProfileViewCollectionCustomCell.self, forCellWithReuseIdentifier: UserProfileViewCollectionCustomCell.collectionViewCellIdentifier)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    let peopleButtonLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        collectionViewFunctions()
        showUserProfileViewLayout()
    }
    
    // userProfileView의 화면 구성
    func showUserProfileViewLayout() {
        // UserProfileView의 타이틀
        let userProfileViewTitle = UILabel()
        userProfileViewTitle.text = userName
        userProfileViewTitle.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(userProfileViewTitle)
        userProfileViewTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        // UserProfile image
        let userProfileImage = UIImageView()
        userProfileImage.image = UIImage(named: "UserImage")
        userProfileImage.contentMode = .scaleAspectFit
        userProfileImage.layer.cornerRadius = 50
        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.darkGray.cgColor
        userProfileImage.clipsToBounds = true
        view.addSubview(userProfileImage)
        userProfileImage.snp.makeConstraints { make in
            make.top.equalTo(userProfileViewTitle.snp.bottom).offset(20)
            make.left.equalTo(userProfileViewTitle.snp.left)
            make.width.height.equalTo(100)
        }
        
        // 게시물 수
        let feedCountLabel = UILabel()
        feedCountLabel.text = String(CoreDataManager.shared.getFeeds().count)
        view.addSubview(feedCountLabel)
        feedCountLabel.snp.makeConstraints { make in
            make.left.equalTo(userProfileImage.snp.right).offset(45)
            make.centerY.equalTo(userProfileImage.snp.centerY).offset(-10)
        }
        
        // "게시물" 라벨
        let feedLabel = UILabel()
        feedLabel.text = "게시물"
        view.addSubview(feedLabel)
        feedLabel.snp.makeConstraints { make in
            make.top.equalTo(feedCountLabel.snp.bottom)
            make.centerX.equalTo(feedCountLabel.snp.centerX)
        }
        
        // 팔로워 수
        let followerCountLabel = UILabel()
        followerCountLabel.text = "1M"
        view.addSubview(followerCountLabel)
        followerCountLabel.snp.makeConstraints { make in
            make.left.equalTo(feedCountLabel.snp.right).offset(70)
            make.centerY.equalTo(feedCountLabel.snp.centerY)
        }
        
        // "팔로워" 라벨
        let follwerLabel = UILabel()
        follwerLabel.text = "팔로워"
        view.addSubview(follwerLabel)
        follwerLabel.snp.makeConstraints { make in
            make.top.equalTo(followerCountLabel.snp.bottom)
            make.centerX.equalTo(followerCountLabel.snp.centerX)
        }
        
        // 팔로잉 수
        let followingCountLabel = UILabel()
        followingCountLabel.text = "1M"
        view.addSubview(followingCountLabel)
        followingCountLabel.snp.makeConstraints { make in
            make.left.equalTo(followerCountLabel.snp.right).offset(70)
            make.centerY.equalTo(followerCountLabel.snp.centerY)
        }
        
        // "팔로잉" 라벨
        let followingLabel = UILabel()
        followingLabel.text = "팔로잉"
        view.addSubview(followingLabel)
        followingLabel.snp.makeConstraints { make in
            make.top.equalTo(followerCountLabel.snp.bottom)
            make.centerX.equalTo(followingCountLabel.snp.centerX)
        }
        
        // UserName
        let userName = UILabel()
        userName.text = "장경호"
        userName.font = UIFont.boldSystemFont(ofSize: 17)
        view.addSubview(userName)
        userName.snp.makeConstraints { make in
            make.top.equalTo(userProfileImage.snp.bottom).offset(20)
            make.left.equalTo(userProfileImage.snp.left)
        }
        
        // 한줄 소개
        let userIntroduciton = UILabel()
        userIntroduciton.text = "인스타그램 클론 겁나 어렵네요;"
        userIntroduciton.font = UIFont.systemFont(ofSize: 15)
        view.addSubview(userIntroduciton)
        userIntroduciton.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(5)
            make.left.equalTo(userName.snp.left)
        }
        
        // 프로필 편집 버튼
        let profileEditButton = UIButton()
        profileEditButton.backgroundColor = .white
        profileEditButton.setTitle("프로필 편집", for: .normal)
        profileEditButton.setTitleColor(.black, for: .normal)
        profileEditButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        profileEditButton.layer.borderWidth = 1
        profileEditButton.layer.borderColor = UIColor.lightGray.cgColor
        profileEditButton.layer.cornerRadius = 5
        view.addSubview(profileEditButton)
        profileEditButton.snp.makeConstraints { make in
            make.top.equalTo(userIntroduciton.snp.bottom).offset(10)
            make.centerX.equalTo(view)
            make.width.equalTo(view).offset(-40)
            make.height.equalTo(40)
        }
        profileEditButton.addTarget(self, action: #selector(pressNotFinishButton), for: .allEvents)
        
        // Feed&People 버튼 위의 Divider
        let dividerLabel = UILabel()
        dividerLabel.layer.borderWidth = 1
        dividerLabel.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(dividerLabel)
        dividerLabel.snp.makeConstraints { make in
            make.top.equalTo(profileEditButton.snp.bottom).offset(10)
            make.width.equalTo(view)
            make.height.equalTo(1)
        }
        
        // Feed 버튼
        let feedButton = UIButton()
        feedButton.setImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        feedButton.contentVerticalAlignment = .fill
        feedButton.contentHorizontalAlignment = .fill
        view.addSubview(feedButton)
        feedButton.snp.makeConstraints { make in
            make.top.equalTo(dividerLabel.snp.bottom).offset(10)
            make.left.equalTo(view.safeAreaInsets).offset(100)
            make.size.equalTo(30)
        }
        feedButton.addTarget(self, action: #selector(pressNotFinishButton), for: .allEvents)
        
        // Feed 버튼 라벨
        let feedButtonLabel = UILabel()
        feedButtonLabel.text = "Feed"
        feedButtonLabel.font = UIFont.systemFont(ofSize: 11)
        feedButtonLabel.textColor = .systemBlue
        view.addSubview(feedButtonLabel)
        feedButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(feedButton.snp.bottom)
            make.centerX.equalTo(feedButton.snp.centerX)
        }
        
        // People 버튼
        let peopleButton = UIButton()
        peopleButton.setImage(UIImage(systemName: "person.crop.square"), for: .normal)
        peopleButton.contentVerticalAlignment = .fill
        peopleButton.contentHorizontalAlignment = .fill
        view.addSubview(peopleButton)
        peopleButton.snp.makeConstraints { make in
            make.top.equalTo(dividerLabel.snp.bottom).offset(10)
            make.right.equalTo(view.safeAreaInsets).offset(-100)
            make.size.equalTo(30)
        }
        peopleButton.addTarget(self, action: #selector(pressNotFinishButton), for: .allEvents)
        
        // People 버튼 라벨
        peopleButtonLabel.text = "People"
        peopleButtonLabel.textColor = .systemBlue
        peopleButtonLabel.font = UIFont.systemFont(ofSize: 11)
        view.addSubview(peopleButtonLabel)
        peopleButtonLabel.snp.makeConstraints { make in
            make.top.equalTo(peopleButton.snp.bottom)
            make.centerX.equalTo(peopleButton.snp.centerX)
        }
        
        showCollectionView()
    }
    
    // show collecionView
    func showCollectionView() {
        view.addSubview(feedCollectionView)
        feedCollectionView.snp.makeConstraints { make in
            make.top.equalTo(peopleButtonLabel.snp.bottom).offset(10)
            make.width.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        let noSpacing = UICollectionViewFlowLayout()
        noSpacing.minimumLineSpacing = 0
        noSpacing.minimumInteritemSpacing = 0
        feedCollectionView.setCollectionViewLayout(noSpacing, animated: true)
    }
    
    func collectionViewFunctions() {
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        feedCollectionView.reloadData()
    }
    
    // '준비 중인 기능'에 대한 함수
    @objc func pressNotFinishButton() {
        let profileEditButtomAlert = UIAlertController(title: "준비 중인 기능입니다.", message: nil, preferredStyle: .alert)
        let checkButton = UIAlertAction(title: "OK", style: .default)
        profileEditButtomAlert.addAction(checkButton)
        
        present(profileEditButtomAlert, animated: true, completion: nil)
    }

}

extension UserProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3, height: view.frame.width/3)
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CoreDataManager.shared.getFeeds().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: UserProfileViewCollectionCustomCell.collectionViewCellIdentifier, for: indexPath) as? UserProfileViewCollectionCustomCell else { return UICollectionViewCell() }
        let newFeedForCollectionViewCell = CoreDataManager.shared.getFeeds()
        
        collectionViewCell.feedImage.image = UIImage(data: newFeedForCollectionViewCell[indexPath.row].feedImage!)
        
        return collectionViewCell
    }
    
}
