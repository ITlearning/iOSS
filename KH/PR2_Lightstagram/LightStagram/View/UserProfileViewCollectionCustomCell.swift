//
//  UserProfileViewCollectionCustomCell.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/24.
//

import UIKit
import SnapKit

class UserProfileViewCollectionCustomCell: UICollectionViewCell {
    
    static let collectionViewCellIdentifier = "UserProfileViewCollectionCustomCell"
    
    let feedImage: UIImageView = {
        let feedImage = UIImageView()
        feedImage.translatesAutoresizingMaskIntoConstraints = false
        feedImage.contentMode = .scaleToFill
//        feedImage.clipsToBounds = true
        
        return feedImage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        collectionViewCellLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionViewCellLayout() {
        contentView.addSubview(feedImage)
        feedImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
}
