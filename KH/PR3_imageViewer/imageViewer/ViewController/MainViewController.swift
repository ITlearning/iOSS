//
//  MainViewController.swift
//  imageViewer
//
//  Created by ROLF J. on 2022/06/28.
//

import UIKit
import SnapKit
import PhotosUI

class MainViewController: UIViewController {
    
    // imageViewer Label
    let imageViewerLabel: UILabel = {
        let label = UILabel()
        label.text = "imageViewer"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        
        return label
    }()
    
    // 이미지들을 보여주는 컬렉션 뷰
    let multipleImageView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MultipleImageViewCell.self, forCellWithReuseIdentifier: MultipleImageViewCell.identifier)
        collectionView.backgroundColor = .systemGray5
        
        return collectionView
    }()
    
    // PHPicker로 선택한 이미지들을 받기 위한 변수
    var itemProviders = [NSItemProvider]()
    
    // '사진 선택하기' 버튼
    let selectButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .purple
        configuration.baseForegroundColor = .white
        button.configuration = configuration
        button.setTitle("사진 선택하기", for: .normal)
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        showMainView()
    }

    func showMainView() {
        view.addSubview(imageViewerLabel)
        view.addSubview(multipleImageView)
        view.addSubview(selectButton)
        
        imageViewerLabel.snp.makeConstraints { label in
            label.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            label.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        multipleImageView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(multipleImageView.snp.width)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(view.frame.width/4)
            make.trailing.equalTo(-(view.frame.width/4))
        }
        selectButton.addTarget(self, action: #selector(showPhotoLibrary), for: .allEvents)
    }
    
    @objc func showPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
}

extension MainViewController: PHPickerViewControllerDelegate {
    
    // 선택을 완료하면 실행되는 함수(Add 클릭)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        itemProviders = results.map(\.itemProvider)
        for newImage in itemProviders {
            if newImage.canLoadObject(ofClass: UIImage.self) {
                newImage.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        guard let image = image as? UIImage else { return }
                        collectionViewImages.append(image)
                        self.multipleImageView.reloadData()
                    }
                }
            }
        }
    }
    
}
