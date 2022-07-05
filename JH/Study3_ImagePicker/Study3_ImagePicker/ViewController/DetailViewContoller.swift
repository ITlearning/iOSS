//
//  DetailViewContoller.swift
//  Study3_ImagePicker
//
//  Created by Jaehyeok Lim on 2022/06/29.
//

import UIKit
import SnapKit

public var indexForDetailView = 0

class DetailViewController: UIViewController {
    
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
        collectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func collectionViewLayout() {
        collectionView.register(DetailViewCustomCell.self, forCellWithReuseIdentifier: "DetailViewCustomCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = UIColor.black
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.bottom.equalTo(view)
            make.leading.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    @objc func closeButtonAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }

        dismiss(animated: true, completion: { indexForDetailView = indexPath.row })
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainList[indexPathForViewr].totalPhotos
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailViewCustomCell", for: indexPath) as? DetailViewCustomCell else { return UICollectionViewCell() }
        
        if indexForSubView != 0 {
            collectionView.scrollToItem(at: IndexPath(item: indexForSubView, section: 0), at: .init(rawValue: 0), animated: true)
            indexForSubView = 0
        }
        
        if indexPathForViewr == 0 {
            cell.transfortImage(image: subList[indexPathForViewr + indexPath.row].subDataImage)
            cell.transfortLabel(currentImageIndex: String(indexPath.row + 1), totalImageIndex: String(mainList[indexPathForViewr].totalPhotos))
        } else if indexPathForViewr == 1 {
            cell.transfortImage(image: subList[(mainList[0].totalPhotos) + indexPath.row].subDataImage)
            cell.transfortLabel(currentImageIndex: String(indexPath.row + 1), totalImageIndex: String(mainList[indexPathForViewr].totalPhotos))
        } else {
            cell.transfortImage(image: subList[(mainList[indexPathForViewr - 2].totalPhotos + mainList[indexPathForViewr - 1].totalPhotos) + indexPath.row].subDataImage)
            cell.transfortLabel(currentImageIndex: String(indexPath.row + 1), totalImageIndex: String(mainList[indexPathForViewr].totalPhotos))
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

