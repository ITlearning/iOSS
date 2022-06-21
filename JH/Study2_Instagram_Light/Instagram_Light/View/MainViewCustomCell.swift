//
//  CustomCell.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/16.
//

import UIKit
import SnapKit

class MainViewCustomCell: UITableViewCell {
    static let identifier = "MainViewCustomCell"
    static let userBaseImage = UIImage(named: "MainUserImage")
    
    private let userProfileImage: UIImageView = {
        let userProfileImage = UIImageView()
        
        userProfileImage.backgroundColor = .red
        userProfileImage.image = userBaseImage
        userProfileImage.translatesAutoresizingMaskIntoConstraints = false
        userProfileImage.contentMode = .scaleAspectFit
        userProfileImage.layer.cornerRadius = 22
        userProfileImage.layer.borderWidth = 1
        userProfileImage.layer.borderColor = UIColor.black.cgColor
        userProfileImage.clipsToBounds = true
        
        return userProfileImage
    }()

    private let topSideUserName: UILabel = {
        let topSideUserName = UILabel()
        
        topSideUserName.text = userName
        topSideUserName.textColor = UIColor.black
        topSideUserName.font = UIFont.boldSystemFont(ofSize: 15)
        
        return topSideUserName
    }()
    
    private let bottomSideUserName: UILabel = {
        let bottomSideUserName = UILabel()
        
        bottomSideUserName.text = userName
        bottomSideUserName.textColor = UIColor.black
        bottomSideUserName.font = UIFont.boldSystemFont(ofSize: 15)
        
        return bottomSideUserName
    }()
    
    var mainViewImage: UIImageView = {
        let mainViewImage = UIImageView()
        
        return mainViewImage
    }()
    
    let mainText: UILabel = {
        let mainText = UILabel()
        
        mainText.textColor = UIColor.black
        mainText.font = UIFont.systemFont(ofSize: 15)
        
        return mainText
    }()
    
    private let subText: UILabel = {
        let subText = UILabel()
        
        subText.text = "명이 좋아합니다."
        subText.textColor = UIColor.black
        subText.font = UIFont.systemFont(ofSize: 15)
        
        return subText
    }()
    
    let likeText: UILabel = {
        let likeText = UILabel()
        
        likeText.textColor = UIColor.black
        likeText.font = UIFont.systemFont(ofSize: 15)
        
        return likeText
    }()
    
    let dateText: UILabel = {
        let dateText = UILabel()
        
        dateText.textColor = UIColor.black
        dateText.font = UIFont.systemFont(ofSize: 10)
        
        return dateText
    }()
    
    private func setConstraint() {
        let viewList: [UIView] = [mainViewImage, userProfileImage,topSideUserName, bottomSideUserName, mainText, subText, likeText, dateText]
        
        for view in viewList {
            contentView.addSubview(view)
        }

        userProfileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(36)
            make.bottom.equalToSuperview().offset(-470)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        topSideUserName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(90)
            make.right.equalToSuperview().offset(16)
            make.top.equalTo(userProfileImage).offset(12)
        }
        
        bottomSideUserName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(36)
            make.bottom.equalToSuperview().offset(-33)
        }
        
        mainViewImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.leading.equalToSuperview().offset(26)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-80)
            make.size.equalTo(CGSize(width: 400, height: 300))
        }
        
        mainText.snp.makeConstraints { make in
            make.leading.equalTo(bottomSideUserName).offset(35)
            make.right.equalToSuperview().offset(-73)
            make.top.equalToSuperview().offset(473)
        }
        
        subText.snp.makeConstraints { make in
            make.leading.equalTo(bottomSideUserName).offset(20)
            make.right.equalToSuperview().offset(-73)
            make.top.equalToSuperview().offset(450)
        }
        
        likeText.snp.makeConstraints { make in
            make.leading.equalTo(bottomSideUserName).offset(2)
            make.right.equalToSuperview().offset(-73)
            make.top.equalToSuperview().offset(450)
        }
        
        dateText.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(36)
            make.bottom.equalToSuperview().offset(-15)
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
    
