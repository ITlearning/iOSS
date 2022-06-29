//
//  DetailViewCustomCell.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/29.
//

import UIKit
import SnapKit

class DetailViewCustomCell: UICollectionViewCell {
    
    static let identifier = "DetailViewCustomCell"
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        let scrollViewList: [UIView] = [detailViewImage, closeButton, currentAndTotalImageIndex]
        
        for view in scrollViewList {
            scrollView.addSubview(view)
        }
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    let detailViewImage: UIImageView = {
        let detailViewImage = UIImageView()
        
        detailViewImage.image = UIImage(named: "testImage")
        detailViewImage.contentMode = .scaleAspectFit
        
        return detailViewImage
    }()
    
    let closeButton: UIButton = {
        let closeButton = UIButton()
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        
        return closeButton
    }()
    
    let currentAndTotalImageIndex: UILabel = {
        let currentAndTotalImageIndex = UILabel()
        
        currentAndTotalImageIndex.textColor = .white
        currentAndTotalImageIndex.font = UIFont.systemFont(ofSize: 20)
        
        return currentAndTotalImageIndex
    }()
    
    private func setConstraint() {
        contentView.backgroundColor = UIColor.black

        contentView.addSubview(scrollView)
        
        detailViewImage.snp.makeConstraints { make in
            make.height.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(70)
            make.leading.equalTo(contentView).offset(30)
            make.size.equalTo(CGSize(width: 28, height: 26))
        }
        
        currentAndTotalImageIndex.snp.makeConstraints { make in
            make.top.equalTo(closeButton).offset(5)
            make.leading.equalTo(contentView).offset(180)
        }
//
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        closeButton.addTarget(DetailViewController.closeButtonAction(_:), action: #selector(DetailViewController.closeButtonAction(_:)), for: .touchUpInside)
    }
    
    func transfortImage(image: UIImage) {
        detailViewImage.image = image
    }
    
    func transfortLabel(currentImageIndex: String, totalImageIndex: String) {
        currentAndTotalImageIndex.text = currentImageIndex + " / " + totalImageIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewCustomCell: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailViewImage
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
          if scrollView.zoomScale > 0.1 {
              if let image = detailViewImage.image {
                  let ratioW = detailViewImage.frame.width / image.size.width
                  let ratioH = detailViewImage.frame.height / image.size.height
                  let ratio = ratioW < ratioH ? ratioW:ratioH
                  let newWidth = image.size.width*ratio
                  let newHeight = image.size.height*ratio
                  let left = 0.5 * (newWidth * scrollView.zoomScale > detailViewImage.frame.width ? (newWidth - detailViewImage.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                  let top = 0.5 * (newHeight * scrollView.zoomScale > detailViewImage.frame.height ? (newHeight - detailViewImage.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                  
                  scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
              }
          }
      }
}
