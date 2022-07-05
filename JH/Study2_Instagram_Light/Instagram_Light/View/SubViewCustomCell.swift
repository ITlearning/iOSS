//
//  SubViewCustomCell.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/24.
//

import UIKit
import SnapKit

class SubViewCustomCell: UITableViewCell {
    static let identifier = "SubViewCustomCell"
    static let userBaseImage = UIImage(named: "MainUserImage")
    
    private let userProfileImage: UIImageView = {
        let userProfileImage = UIImageView()
        
        userProfileImage.backgroundColor = .red
        userProfileImage.image = userBaseImage
        userProfileImage.contentMode = .scaleAspectFit
        userProfileImage.layer.cornerRadius = 22
        userProfileImage.layer.borderWidth = 0.5
        userProfileImage.layer.borderColor = UIColor.textColor?.cgColor
        userProfileImage.clipsToBounds = true
        
        return userProfileImage
    }()

    private let topSideUserName: UILabel = {
        let topSideUserName = UILabel()
        
        topSideUserName.text = userName
        topSideUserName.textColor = UIColor.textColor
        topSideUserName.font = UIFont.boldSystemFont(ofSize: 15)
        
        return topSideUserName
    }()
    
    private let bottomSideUserName: UILabel = {
        let bottomSideUserName = UILabel()
        
        bottomSideUserName.text = userName
        bottomSideUserName.textColor = UIColor.textColor
        bottomSideUserName.font = UIFont.boldSystemFont(ofSize: 15)
        
        return bottomSideUserName
    }()
    
    var mainViewImage: UIImageView = {
        let mainViewImage = UIImageView()

        return mainViewImage
    }()
    
    let mainText: UILabel = {
        let mainText = UILabel()
        
        mainText.textColor = UIColor.textColor
        mainText.font = UIFont.systemFont(ofSize: 15)
        
        return mainText
    }()
    
    let commentButton: UIButton = {
        let commentButton = UIButton()
        
        commentButton.setImage(UIImage.init(systemName: "message"), for: .normal)
        commentButton.contentVerticalAlignment = .fill
        commentButton.contentHorizontalAlignment = .fill
        commentButton.tintColor = UIColor.textColor
        
        return commentButton
    }()
    
    let directMessageButton: UIButton = {
        let directMessageButton = UIButton()
        
        directMessageButton.setImage(UIImage.init(systemName: "paperplane"), for: .normal)
        directMessageButton.contentVerticalAlignment = .fill
        directMessageButton.contentHorizontalAlignment = .fill
        directMessageButton.tintColor = UIColor.textColor
        
        return directMessageButton
    }()
    
    private let likeTextBeforeSubText: UILabel = {
        let likeTextBeforeSubText = UILabel()
        
        likeTextBeforeSubText.text = "좋아요"
        likeTextBeforeSubText.textColor = UIColor.textColor
        likeTextBeforeSubText.font = UIFont.boldSystemFont(ofSize: 15)
        
        return likeTextBeforeSubText
    }()
    
    let likeNumberText: UILabel = {
        let likeNumberText = UILabel()
        
        likeNumberText.textColor = UIColor.textColor
        likeNumberText.font = UIFont.boldSystemFont(ofSize: 15)
        
        return likeNumberText
    }()
    
    private let likeTextAfterSubText: UILabel = {
        let likeTextAfterSubText = UILabel()
        
        likeTextAfterSubText.text = "개"
        likeTextAfterSubText.textColor = UIColor.textColor
        likeTextAfterSubText.font = UIFont.boldSystemFont(ofSize: 15)
        
        return likeTextAfterSubText
    }()
    
    let likeButton: UIButton = {
        let likeButton = UIButton()
        
        likeButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
        likeButton.contentVerticalAlignment = .fill
        likeButton.contentHorizontalAlignment = .fill
        likeButton.tintColor = UIColor.textColor
        
        return likeButton
    }()
    
    let dateText: UILabel = {
        let dateText = UILabel()
        
        dateText.textColor = UIColor.textColor
        dateText.font = UIFont.systemFont(ofSize: 10)
        
        return dateText
    }()
    
    let editButton: UIButton = {
        let editButton = UIButton()
        
        editButton.setImage(UIImage.init(systemName: "square.and.pencil"), for: .normal)
        editButton.contentVerticalAlignment = .fill
        editButton.contentHorizontalAlignment = .fill
        editButton.tintColor = UIColor.textColor
        
        return editButton
    }()
    
    let deleteButton: UIButton = {
        let deleteButton = UIButton()
        
        deleteButton.setImage(UIImage.init(systemName: "trash"), for: .normal)
        deleteButton.contentVerticalAlignment = .fill
        deleteButton.contentHorizontalAlignment = .fill
        deleteButton.tintColor = UIColor.textColor
        
        return deleteButton
    }()
    
    
    private func setConstraint() {
        let viewList: [UIView] = [mainViewImage, userProfileImage, topSideUserName,
                                  bottomSideUserName, mainText, likeTextBeforeSubText,
                                  likeTextAfterSubText, likeNumberText, dateText, likeButton,
                                  commentButton, directMessageButton, editButton, deleteButton]
        
        for view in viewList {
            contentView.addSubview(view)
        }
        
        contentView.backgroundColor = UIColor.backgroundColor
        
        userProfileImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        topSideUserName.snp.makeConstraints { make in
            make.top.equalTo(userProfileImage).offset(12)
            make.leading.equalTo(userProfileImage).offset(54)
            make.right.equalToSuperview().offset(16)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(topSideUserName)
            make.leading.equalTo(topSideUserName).offset(290)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalTo(directMessageButton)
            make.leading.equalTo(editButton)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        mainViewImage.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(65)
            make.leading.equalToSuperview()
            make.size.equalTo(CGSize(width: 400, height: 350))
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(userProfileImage).offset(-3)
            make.top.equalTo(contentView).offset(424)
            make.size.equalTo(CGSize(width: 30, height: 25))
        }
        
        commentButton.snp.makeConstraints { make in
            make.leading.equalTo(likeButton).offset(47)
            make.top.equalTo(likeButton)
            make.size.equalTo(CGSize(width: 30, height: 25))
        }

        
        directMessageButton.snp.makeConstraints { make in
            make.leading.equalTo(commentButton).offset(47)
            make.top.equalTo(likeButton)
            make.size.equalTo(CGSize(width: 30, height: 25))
        }
        
        likeTextBeforeSubText.snp.makeConstraints { make in
            make.leading.equalTo(userProfileImage)
            make.top.equalTo(contentView).offset(460)
        }
        
        likeNumberText.snp.makeConstraints { make in
            make.leading.equalTo(likeTextBeforeSubText).offset(45)
            make.top.equalTo(likeTextBeforeSubText)
        }
        
        likeTextAfterSubText.snp.makeConstraints { make in
            make.right.equalTo(likeNumberText).offset(13)
            make.top.equalTo(likeNumberText)
        }
        
        bottomSideUserName.snp.makeConstraints { make in
            make.leading.equalTo(userProfileImage)
            make.top.equalTo(likeNumberText).offset(20)
        }
        
        mainText.snp.makeConstraints { make in
            make.leading.equalTo(bottomSideUserName).offset(100)
            make.top.equalTo(bottomSideUserName)
        }
        
        dateText.snp.makeConstraints { make in
            make.leading.equalTo(userProfileImage)
            make.top.equalTo(mainText).offset(35)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        likeButton.addTarget(self, action:#selector(self.likeButtonAction), for: .touchUpInside)
        editButton.addTarget(SubViewController.editButtonAction(_:), action: #selector(SubViewController.editButtonAction), for: .touchUpInside)
        deleteButton.addTarget(SubViewController.deleteButtonAction(_:), action: #selector(SubViewController.deleteButtonAction), for: .touchUpInside)
    }
    
    @objc func likeButtonAction() {
        
        if likeButton.tintColor == .red {
            likeButton.setImage(UIImage.init(systemName: "heart"), for: .normal)
            likeButton.tintColor = UIColor.textColor
            
            likeNumberText.text = String(Int(likeNumberText.text ?? "")! - 1)
            
        } else {
            likeButton.setImage(UIImage.init(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
            
            likeNumberText.text = String(Int(likeNumberText.text ?? "")! + 1)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
        
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
    
