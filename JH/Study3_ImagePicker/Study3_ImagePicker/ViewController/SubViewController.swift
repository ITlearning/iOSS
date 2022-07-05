//
//  SubViewController.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/26.
//

import UIKit
import SnapKit

public var indexForSubView = 0

public extension UIColor {
    static let backgroundColor = UIColor(named: "backgroundColor")
    static let commonTextColor = UIColor(named: "commonTextColor")
}

class SubViewController: UIViewController {
    
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
        
        configureLayout()
        collectionViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureLayout() {
        view.backgroundColor = UIColor.backgroundColor
        
        let subViewImagePickUpButton = UIButton()
        
        subViewImagePickUpButton.backgroundColor = UIColor.systemBlue
        subViewImagePickUpButton.setTitle("PickUp Your Image!", for: .normal)
        subViewImagePickUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        subViewImagePickUpButton.layer.borderWidth = 0.5
        subViewImagePickUpButton.layer.borderColor = UIColor.systemBlue.cgColor
        subViewImagePickUpButton.layer.cornerRadius = 20
        
        view.addSubview(subViewImagePickUpButton)
        
        subViewImagePickUpButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(700)
            make.leading.equalTo(view).offset(45)
            make.size.equalTo(CGSize(width: 300, height: 40))
        }
        
        let addButton = UIButton()
        
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.contentVerticalAlignment = .fill
        addButton.contentHorizontalAlignment = .fill
        
        view.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.right.equalTo(view).offset(-30)
            make.size.equalTo(CGSize(width: 32, height: 30))
        }
        
        let closeButton = UIButton()
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.contentVerticalAlignment = .fill
        closeButton.contentHorizontalAlignment = .fill
        
        view.addSubview(closeButton)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(70)
            make.leading.equalTo(view).offset(30)
            make.size.equalTo(CGSize(width: 28, height: 26))
        }
        
        closeButton.addTarget(self, action: #selector(closeButtonAction(_:)), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonAction(_:)), for: .touchUpInside)
}
    
    @objc func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    @objc func addButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    func collectionViewLayout() {
        
        collectionView.register(SubViewCustomCell.self, forCellWithReuseIdentifier: "SubViewCustomCell")
        
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
    
    @objc func SubImageViewAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        let myViewController = DetailViewController()
        
        indexForSubView = indexPath.row
        
        myViewController.modalPresentationStyle = .fullScreen
        present(myViewController, animated: true, completion: nil)
    }
}

extension SubViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList[indexPathForViewr].totalPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubViewCustomCell", for: indexPath) as? SubViewCustomCell else { return UICollectionViewCell() }
        
        if indexForDetailView != 0 {
            collectionView.scrollToItem(at: IndexPath(item: indexForDetailView, section: 0), at: .centeredHorizontally, animated: true)
            indexForDetailView = 0
        }
        
        if indexPathForViewr == 0 {
            cell.transfortImage(image: subList[indexPathForViewr + indexPath.row].subDataImage)
        } else if indexPathForViewr == 1 {
            cell.transfortImage(image: subList[(mainList[0].totalPhotos) + indexPath.row].subDataImage)
        } else {
            cell.transfortImage(image: subList[(mainList[indexPathForViewr - 2].totalPhotos + mainList[indexPathForViewr - 1].totalPhotos) + indexPath.row].subDataImage)
        }

        return cell
    }
}

extension SubViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height - 550)
    }
}


