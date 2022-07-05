//
//  MainViewController.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/26.
//

import UIKit
import SnapKit
import PhotosUI

public var indexPathForViewr = 0

private var imageArray: [UIImage] = []
private var itemProviders: [NSItemProvider] = []

class MainViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)

        flowLayout.minimumLineSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAlbum()
        configureLayout()
        collectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    private func addView() {
        if imageArray.count != 0 {
            
            let popup = UIAlertController(title: "알림", message: "앨범 이름 작성", preferredStyle: .alert)
            
            popup.addTextField { (textField) in
                
                textField.placeholder = "여기에 작성해주세요."
            }
            
            let addTextAlertAction = UIAlertAction(title: "등록", style: .default) { action in
                let aaa = UILabel()
                aaa.text = popup.textFields?[0].text
                
                let mainItem: MainData = MainData(albumTitleImage: subList[subList.count - imageArray.count].subDataImage, albumTitleLabel: aaa.text!, albumIndex: 0, totalPhotos: imageArray.count)
                
                mainList.insert(mainItem, at: mainList.count - 1)
                self.collectionView.reloadData()
                imageArray.removeAll()
                
            }
            
            popup.addAction(addTextAlertAction)
            present(popup, animated: true, completion: nil)
        }
    }
    
    private func addAlbum() {
        let item = [MainData(albumTitleImage: UIImage(systemName: "plus.rectangle")!, albumTitleLabel: "", albumIndex: .zero, totalPhotos: .zero)]
        mainList.append(contentsOf: item)
    }
    
    private func configureLayout() {
        view.backgroundColor = UIColor.backgroundColor
        
        let subViewTitleLabel = UILabel()
        
        subViewTitleLabel.text = "ImagePicker"
        subViewTitleLabel.textColor = UIColor.commonTextColor
        subViewTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(subViewTitleLabel)
        
        subViewTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(80)
            make.leading.equalTo(view).offset(20)
        }
        
        let subViewTitleImageView = UIImageView()
        
        subViewTitleImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
        subViewTitleImageView.tintColor = UIColor.systemBlue
        
        view.addSubview(subViewTitleImageView)
        
        subViewTitleImageView.snp.makeConstraints { make in
            make.top.equalTo(subViewTitleLabel)
            make.right.equalTo(subViewTitleLabel).offset(40)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
    }
    
    func collectionViewLayout() {
        collectionView.register(MainViewCustomCell.self, forCellWithReuseIdentifier: "MainViewCustomCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.backgroundColor = UIColor.backgroundColor
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(220)
            make.bottom.equalTo(view).offset(-220)
            make.leading.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    @objc func albumTitleImageAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        if indexPath.row == mainList.count - 1 {
            
            checkAlbumPermission()
            
            var configuration = PHPickerConfiguration()
            
            configuration.selectionLimit = 0
            configuration.filter = .any(of: [.images, .videos])
            
            let picker = PHPickerViewController(configuration: configuration)
            
            picker.delegate = self
            picker.modalPresentationStyle = .fullScreen
            
            self.present(picker, animated: true, completion: nil)
            
        } else {
            let myViewController = SubViewController()
            indexPathForViewr = indexPath.row
            
            myViewController.modalPresentationStyle = .fullScreen
            present(myViewController, animated: true, completion: nil)
        }
    }
    
    func checkAlbumPermission(){
            PHPhotoLibrary.requestAuthorization( { status in
                switch status{
                case .authorized:
                    print("Album: 권한 허용")
                case .denied:
                    print("Album: 권한 거부")
                case .restricted, .notDetermined:
                    print("Album: 선택하지 않음")
                default:
                    break
                }
            })
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainViewCustomCell", for: indexPath) as? MainViewCustomCell else { return UICollectionViewCell() }
        
        cell.transfortImage(image: mainList[indexPath.row].albumTitleImage)
        cell.transfortTitleLabel(titleTexts: mainList[indexPath.row].albumTitleLabel)
        
        if indexPath.row == (mainList.count - 1) {
            cell.transfortIndexLabel(indexTexts: "")
            cell.transfortHashTagIcon(iconTexts: "")
            
        } else {
            cell.transfortIndexLabel(indexTexts: String(indexPath.row))
            cell.transfortHashTagIcon(iconTexts: "#")
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height - 550)
    }
}

extension MainViewController: PHPickerViewControllerDelegate {
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: { self.addView(); })
    
            itemProviders = results.map(\.itemProvider)
            
            for item in itemProviders {
                if item.canLoadObject(ofClass: UIImage.self) {
                    item.loadObject(ofClass: UIImage.self) { image, error in
                        DispatchQueue.main.async {
                            guard let image = image as? UIImage else { return }
                            let subListItem: SubData = SubData(subDataImage: image)

                            subList.append(subListItem)
                            imageArray.append(image)
                        }
                    }
                }
            }
        }
}
