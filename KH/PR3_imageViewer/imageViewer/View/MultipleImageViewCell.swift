//
//  MultipleImageViewCell.swift
//  imageViewer
//
//  Created by ROLF J. on 2022/06/28.
//

import UIKit

class MultipleImageViewCell: UICollectionViewCell {
    
    static let identifier = "MultipleImageViewCell"
    
    let selectedImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        collectionViewCellLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UIImage를 받고 Collection View의 이미지에 할당
    func setImage(getImage: UIImage) {
        selectedImage.image = getImage
    }
    
    func collectionViewCellLayout() {
        contentView.addSubview(selectedImage)
        selectedImage.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.width.equalTo(contentView)
            make.height.equalTo(contentView)
        }
    }
    
}
