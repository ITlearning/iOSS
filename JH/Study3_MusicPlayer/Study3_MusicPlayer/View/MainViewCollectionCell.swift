//
//  MainViewCollectionCell.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/06/30.
//

import UIKit
import SnapKit

class MainViewCollectionCell: UICollectionViewCell {
    static let identifier = "MainViewCollectionCell"
    
    lazy var item: UIImageView = {
        let item = UIImageView()
        
        return item
    }()
    
    lazy var mainCellTitleImage: UIImageView = {
        let mainCellTitleImage = UIImageView()
        
        return mainCellTitleImage
    }()
    
    lazy var mainCellTitleLabel: UILabel = {
        let mainCellTitleLabel = UILabel()
        
        mainCellTitleLabel.textColor = UIColor.cellTitleTextColor
        mainCellTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        mainCellTitleLabel.textAlignment = .center
        
        return mainCellTitleLabel
    }()
    
    lazy var mainCellSingerLabel: UILabel = {
        let mainCellSingerLabel = UILabel()
        
        mainCellSingerLabel.textColor = UIColor.cellTextColor
        mainCellSingerLabel.font = UIFont.boldSystemFont(ofSize: 15)
        mainCellSingerLabel.textAlignment = .center
        
        return mainCellSingerLabel
    }()
    
    lazy var mainCellAlbumLabel: UILabel = {
        let mainCellAlbumLabel = UILabel()
        
        mainCellAlbumLabel.textColor = UIColor.white
        mainCellAlbumLabel.font = UIFont.boldSystemFont(ofSize: 11)
        mainCellAlbumLabel.textAlignment = .center
        
        return mainCellAlbumLabel
    }()
    
    lazy var mainCellSongDate: UILabel = {
        let mainCellSongDate = UILabel()
        
        mainCellSongDate.textColor = UIColor.cellTextColor
        mainCellSongDate.font = UIFont.boldSystemFont(ofSize: 11)
        mainCellSongDate.textAlignment = .center
        
        return mainCellSongDate
    }()
    
    func setConstraint() {
        
        contentView.backgroundColor = .blue
        let viewList: [UIView] = [item, mainCellTitleLabel, mainCellSingerLabel, mainCellTitleImage, mainCellAlbumLabel, mainCellSongDate]
        
        for view in viewList {
            addSubview(view)
        }
        
        item.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(contentView)
        }
        
        mainCellTitleImage.snp.makeConstraints { make in
            make.center.equalTo(item)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        mainCellTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(40)
            make.leading.right.equalTo(0)
            make.width.equalTo(contentView)
        }
        
        mainCellSingerLabel.snp.makeConstraints { make in
            make.top.equalTo(mainCellTitleLabel).offset(37)
            make.leading.right.equalTo(0)
            make.width.equalTo(contentView)
        }
        
        mainCellAlbumLabel.snp.makeConstraints { make in
            make.top.equalTo(mainCellTitleLabel).offset(300)
            make.leading.right.equalTo(0)
            make.width.equalTo(contentView)
        }
        
        mainCellSongDate.snp.makeConstraints { make in
            make.top.equalTo(mainCellAlbumLabel).offset(-20)
            make.leading.right.equalTo(0)
            make.width.equalTo(contentView)
        }
        
        let blurEffect = UIBlurEffect(style: .regular)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.contentView.frame
        self.item.addSubview(visualEffectView)
    }
    
    func transportDataToCell(titleImage: UIImage, titleText: String, singerText: String, albumText: String, dateText: String) {
        item.image = titleImage
        mainCellTitleImage.image = titleImage
        mainCellTitleLabel.text = titleText
        mainCellSingerLabel.text = singerText
        mainCellAlbumLabel.text = "[" + albumText + "]"
        mainCellSongDate.text = "BORN:" + dateText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
