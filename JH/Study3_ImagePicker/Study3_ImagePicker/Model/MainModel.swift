//
//  MainModel.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/26.
//

import UIKit

var mainList = [MainData]()

struct MainData {
    let albumTitleImage: UIImage
    let albumTitleLabel: String
    let albumIndex: Int
    let totalPhotos: Int
}
