//
//  UserCustomCell.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/17.
//

import UIKit
import SnapKit

class UserViewCustomCell: UICollectionViewCell {
    static let identifier = "UserViewCustomCell"

    let UserViewImage: UIImageView = {
        let UserViewImage = UIImageView()
        
        return UserViewImage
    }()
    
    private func setConstraint() {
        addSubview(UserViewImage)

        UserViewImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.rightMargin.equalToSuperview()
//            make.size.equalTo(CGSize(width: 400, height: 300))
        }
    }
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setConstraint()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


