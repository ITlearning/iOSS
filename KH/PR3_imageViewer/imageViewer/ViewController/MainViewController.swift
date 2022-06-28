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
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MultipleImageViewCell.self, forCellWithReuseIdentifier: MultipleImageViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray5
        
        return collectionView
    }()
    
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
        
        MainViewLayout()
    }

    // Main View의 레이아웃
    func MainViewLayout() {
        multipleImageView.delegate = self
        multipleImageView.dataSource = self
        
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
            make.height.equalTo(((view.frame.width)/16)*9)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(view.frame.width/4)
            make.trailing.equalTo(-(view.frame.width/4))
        }
        selectButton.addTarget(self, action: #selector(showPhotoLibrary), for: .allEvents)
    }
    
    // PHPicker를 띄우는 함수
    @objc func showPhotoLibrary() {
        var configuration = PHPickerConfiguration()
        // 선택할 수 있는 이미지 갯수 최댓값
        configuration.selectionLimit = 0
        // 선택할 수 있는 item을 image 형식으로 제한(LivePhoto, Video도 있음)
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true, completion: nil)
    }
}

extension MainViewController: PHPickerViewControllerDelegate {
    
    // 선택을 완료하면 실행되는 함수(Add 클릭)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        // 배열에 남은 이미지가 있다면 전부 비움
        if collectionViewImages.count != 0 {
            collectionViewImages.removeAll()
        }
        
        // PHPicker로 선택한 이미지들을 받기 위한 변수
        var itemProviders = [NSItemProvider]()
        
        // 가져온 사진들을 collectionViewImages 배열에 저장
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
        
        // picker 화면을 없앰
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("\n", collectionViewImages.count, "\n")
        return collectionViewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 70, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleImageViewCell.identifier, for: indexPath) as? MultipleImageViewCell else { return UICollectionViewCell() }
        imageCell.setImage(getImage: collectionViewImages[indexPath.row])
        
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectionViewController = SelectImageViewController()
        selectionViewController.modalTransitionStyle = .coverVertical
        selectionViewController.modalPresentationStyle = .fullScreen
        present(selectionViewController, animated: true, completion: nil)
    }
}
