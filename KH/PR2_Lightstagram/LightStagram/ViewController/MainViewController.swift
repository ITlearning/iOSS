//
//  MainViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit
import SnapKit
import CoreData
import AVFoundation
import Photos

public let userName = "JKH"

class MainViewController: UIViewController {
    
    let mainViewTitle = UILabel()
    private let feedTableView: UITableView = {
        let feedTableView = UITableView()
        feedTableView.register(MainViewTableCustomCell.self, forCellReuseIdentifier: MainViewTableCustomCell.tableViewCellIdentifier)
        return feedTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraPermission()
        photoLibraryPermission()
        tableViewFunctions()
        refreshTableView()
        showMainViewLayout()
    }
        
    // MainView의 화면 구성
    func showMainViewLayout() {
        view.backgroundColor = .white
        
        // MainView의 타이틀
        mainViewTitle.text = "LightStagram"
        mainViewTitle.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(mainViewTitle)
        mainViewTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        showFeedTable()
    }
    
    // MainView의 테이블뷰
    func showFeedTable() {
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints { make in
            make.top.equalTo(mainViewTitle.snp.bottom).offset(10)
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
    }
    
    func tableViewFunctions() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
//        feedTableView.estimatedRowHeight = 580
        feedTableView.rowHeight = 580
        feedTableView.flashScrollIndicators()
        feedTableView.selectionFollowsFocus = false
        refreshTableView()
    }
    
    func refreshTableView() {
        feedTableView.reloadData()
    }
    
    // Camera 사용 허가
    func cameraPermission() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print("Camera: 권한 허용")
            } else {
                print("Camera: 권한 거부")
            }
        })
    }
    
    // 사진 앨범 사용 허가
    func photoLibraryPermission() {
        PHPhotoLibrary.requestAuthorization( { status in
            switch status {
            case .authorized:
                print("Album: 권한 허용")
            case .denied:
                print("Album: 권한 거부")
            case .notDetermined, .restricted:
                print("Album: 선택하지 않음")
            default:
                break
            }
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.shared.getFeeds().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedCell = tableView.dequeueReusableCell(withIdentifier: MainViewTableCustomCell.tableViewCellIdentifier, for: indexPath) as? MainViewTableCustomCell else { return UITableViewCell() }
        let newFeedForCell = CoreDataManager.shared.getFeeds()
        feedCell.feedImageView.image = UIImage(data: newFeedForCell[indexPath.row].feedImage!)
        feedCell.feedText.text = newFeedForCell[indexPath.row].feedText
        feedCell.feedLikeCount.text = newFeedForCell[indexPath.row].likeCount
        feedCell.feedUploadDate.text = newFeedForCell[indexPath.row].uploadDate
        
        self.feedTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        return feedCell
    }
    
    // 셀을 오른쪽에서 쓸었을 때 수정/삭제의 기능이 구현하려고 함 -> 미구현
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete", handler: { action, view, completionHandler in
            print("delete")
            let getFeedForDelete: [Feed] = CoreDataManager.shared.getFeeds()
            tableViewFeedList.remove(at: indexPath.row)
            collectionViewFeedList.remove(at: indexPath.row)
            self.feedTableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.deleteFeed(feedText: getFeedForDelete[indexPath.row].feedText!)
            self.feedTableView.reloadData()
            completionHandler(true)
        })
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { action, view, completionHandler in
            print("edit")
            completionHandler(true)
        })
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    private func getIndexPath(view: UIView) -> IndexPath? {
        let viewPoint = view.convert(CGPoint.zero, to: feedTableView)
        return feedTableView.indexPathForRow(at: viewPoint)
    }
}

