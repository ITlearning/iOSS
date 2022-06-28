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
        image.contentMode = .scaleToFill
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        collectionViewCellLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionViewCellLayout() {
        contentView.addSubview(selectedImage)
        selectedImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
    
}
