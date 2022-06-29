//
//  MainViewCustomCell.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/26.
//

import UIKit
import SnapKit

class MainViewCustomCell: UICollectionViewCell {
    static let identifier = "MainViewCustomCell"
    
    let albumTitleImage: UIButton = {
        let albumTitleImage = UIButton()
        
        albumTitleImage.contentHorizontalAlignment = .fill
        albumTitleImage.contentVerticalAlignment = .fill
        
        return albumTitleImage
    }()
    
    let albumTitleLabel: UILabel = {
        let albumTitleLabel = UILabel()
        
        albumTitleLabel.text = ""
        albumTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        albumTitleLabel.textColor = UIColor.commonTextColor
        
        return albumTitleLabel
    }()
    
    let albumIndexLabel: UILabel = {
       let albumIndexLabel = UILabel()
        
        albumIndexLabel.text = ""
        albumIndexLabel.font = UIFont.boldSystemFont(ofSize: 20)
        albumIndexLabel.textColor = UIColor.systemBlue
        
        return albumIndexLabel
    }()
    
    let hashTagIcon: UILabel = {
       let hashTagIcon = UILabel()
        
        hashTagIcon.text = "#"
        hashTagIcon.font = UIFont.boldSystemFont(ofSize: 20)
        hashTagIcon.textColor = UIColor.systemBlue
        
        return hashTagIcon
    }()
    
    private func setConstraint() {
        contentView.backgroundColor = UIColor.backgroundColor
    
        let viewList: [UIView] = [albumTitleImage, albumTitleLabel, albumIndexLabel, hashTagIcon]
        
        for view in viewList {
            contentView.addSubview(view)
        }
        
        albumTitleImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        albumTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(albumTitleImage).offset(-30)
            make.leading.equalTo(albumTitleImage).offset(30)
        }
        
        albumIndexLabel.snp.makeConstraints { make in
            make.top.equalTo(albumTitleLabel)
            make.leading.equalTo(albumTitleLabel).offset(-14)
        }
        
        hashTagIcon.snp.makeConstraints { make in
            make.top.equalTo(albumIndexLabel)
            make.leading.equalTo(albumIndexLabel).offset(-12)
        }
        
        albumTitleImage.addTarget(MainViewController.albumTitleImageAction, action: #selector(MainViewController.albumTitleImageAction(_:)), for: .touchUpInside)
    }
    
    func transfortImage(image: UIImage) {
        albumTitleImage.setImage(image, for: .normal)
    }
    
    func transfortTitleLabel(titleTexts: String) {
        albumTitleLabel.text = titleTexts
    }
    
    func transfortIndexLabel(indexTexts: String) {
        albumIndexLabel.text = indexTexts
    }
    
    func transfortHashTagIcon(iconTexts: String) {
        hashTagIcon.text = iconTexts
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
