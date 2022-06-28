//
//  MainViewTableCustomCell.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/21.
//

import UIKit
import SnapKit

class MainViewTableCustomCell: UITableViewCell {

    static let tableViewCellIdentifier = "MainViewTableCustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // User image
    let userProfileImage: UIImageView = {
        let userProfileImage = UIImageView()
        userProfileImage.image = UIImage(named: "UserImage")
        userProfileImage.contentMode = .scaleAspectFit
        userProfileImage.layer.cornerRadius = 22
        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.darkGray.cgColor
        userProfileImage.clipsToBounds = true
        return userProfileImage
    }()

    // 프로필 이미지 우측의 userName
    let userNameBesideuserImage: UILabel = {
        let userNameBesideuserImage = UILabel()
        userNameBesideuserImage.text = userName
        userNameBesideuserImage.textColor = .black
        userNameBesideuserImage.font = UIFont.boldSystemFont(ofSize: 17)
        return userNameBesideuserImage
    }()

    // 피드의 이미지(newFeedImageView)
    var feedImageView: UIImageView = {
        let feedImageView = UIImageView()
        feedImageView.contentMode = .scaleToFill
        feedImageView.clipsToBounds = true
        return feedImageView
    }()
    
    // 피드의 좋아요 수(likeCount)
    let feedLikeCount: UILabel = {
        let feedLikeCount = UILabel()
        feedLikeCount.font = UIFont.systemFont(ofSize: 15)
        return feedLikeCount
    }()

    // 피드 설명글 왼쪽의 userName
    let userNameBesideFeedText: UILabel = {
        let userNameBesideFeedText = UILabel()
        userNameBesideFeedText.text = userName
        userNameBesideFeedText.font = UIFont.boldSystemFont(ofSize: 17)
        return userNameBesideFeedText
    }()

    // 피드의 설명글(newFeedTextView)
    let feedText: UILabel = {
        let feedText = UILabel()
        feedText.font = UIFont.systemFont(ofSize: 15)
        return feedText
    }()

    // 피드의 업로드 날짜(uploadDate) - 테스트 중
    let feedUploadDate: UILabel = {
        let feedUploadDate = UILabel()
        feedUploadDate.textColor = .lightGray
        feedUploadDate.font = UIFont.systemFont(ofSize: 12)
        return feedUploadDate
    }()
    
    // Cell의 화면 구성
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubviews([userProfileImage, userNameBesideuserImage, feedImageView, feedLikeCount, userNameBesideFeedText, feedText, feedUploadDate])
        
        userProfileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        userNameBesideuserImage.snp.makeConstraints { make in
            make.left.equalTo(userProfileImage.snp.right).offset(10)
            make.centerY.equalTo(userProfileImage.snp.centerY)
        }
        
        feedImageView.snp.makeConstraints { make in
            make.top.equalTo(userProfileImage.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.width)
        }
        
        feedLikeCount.snp.makeConstraints { make in
            make.top.equalTo(feedImageView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
        
        userNameBesideFeedText.snp.makeConstraints { make in
            make.top.equalTo(feedLikeCount.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
        
        feedText.snp.makeConstraints { make in
            make.left.equalTo(userNameBesideFeedText.snp.right).offset(10)
            make.centerY.equalTo(userNameBesideFeedText.snp.centerY)
        }
        
        feedUploadDate.snp.makeConstraints { make in
            make.top.equalTo(feedText.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
    }
    
    // View들을 한 번에 addSubview 시켜주는 함수
    func addSubviews(_ views: [UIView]) {
        for view in views {
            contentView.addSubview(view)
        }
    }
}
