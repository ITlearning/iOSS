//
//  FeedCell.swift
//  LightInstagram
//
//  Created by ROLF J. on 2022/05/23.
//

import Foundation
import UIKit

struct feedCell {
    var feedUserImage = UIImage() // userImage
    var feedUserName = String?.self // 맨 위 userImage 우측, 아래 textField 우측
    
    var feedImage = UIImage() // feedImage
    
    var feedLike = UILabel() // Rand()명이 좋아합니다.
    var feedTitle = UILabel() // feed에 적을 글
    
    var feedUploadTime = UILabel() // date() 함수로 출력
}
