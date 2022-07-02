//
//  MainViewTableCell.swift
//  Study3_MusicPlayer
//
//  Created by Jaehyeok Lim on 2022/07/02.
//

import UIKit
import SnapKit

class MainViewTableCell: UITableViewCell {
    let identifier = "MainViewTableCell"
    
    lazy var lyricsLabel: UILabel = {
        let lyricsLabel = UILabel()
        
        lyricsLabel.textColor = .systemGray
        lyricsLabel.font = UIFont.systemFont(ofSize: 15)
        lyricsLabel.textAlignment = .center
        
        return lyricsLabel
    }()
    
    func setConstraint() {
        addSubview(lyricsLabel)
        
        lyricsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(contentView)
        }
    }
    
    func transportDataToCell(lyricsText: String) {
        lyricsLabel.text = lyricsText
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
