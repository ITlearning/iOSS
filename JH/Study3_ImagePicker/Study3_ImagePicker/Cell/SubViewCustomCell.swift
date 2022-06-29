//
//  SubViewCustomCell.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/26.
//

import UIKit
import SnapKit

class SubViewCustomCell: UICollectionViewCell {
    static let identifier = "SubViewCustomCell"

    let subViewImage: UIButton = {
        let subViewImage = UIButton()
        
        subViewImage.contentHorizontalAlignment = .fill
        subViewImage.contentVerticalAlignment = .fill
        
        return subViewImage
    }()
    
    private func setConstraint() {
        contentView.backgroundColor = UIColor.backgroundColor
        addSubview(subViewImage)
        
        subViewImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        subViewImage.addTarget(SubViewController.SubImageViewAction(_:), action: #selector(SubViewController.SubImageViewAction(_:)), for: .touchUpInside)
    }
    
    func transfortImage(image: UIImage) {
        subViewImage.setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
