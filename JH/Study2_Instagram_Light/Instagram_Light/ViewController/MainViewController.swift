//
//  ViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/05/26.
//

import UIKit
import SnapKit
import AVFoundation
import Photos

public extension UIColor {
    static let textColor = UIColor(named: "TextColor")
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let subTextColor = UIColor(named: "SubTextColorOne")
}

public var editJudgeNumber = 0
public var indexPathrowForEdit = 0

class MainViewController: UIViewController {

    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        
        checkCameraPermission()
        checkAlbumPermission()
        configureLayout()
        getAllUsers()
    }
    
    func configureLayout() {
        let mainTitleText = UILabel()
        
        mainTitleText.text = "CloneStagram"
        mainTitleText.textColor = UIColor.textColor
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTitleText)

        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainViewCustomCell.self, forCellReuseIdentifier: "MainViewCustomCell")
        tableView.backgroundColor = UIColor.backgroundColor
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.right.bottom.equalToSuperview()
        }
    }
    
    fileprivate func getAllUsers() {
        let mainData: [MainDataEntity] = CoreDataManager.shared.getUsers()

        if mainData.count != 0 {
            for i in 0...mainData.count - 1 {
                if (mainData[i].likeText == nil) {
                    print("fail")
                } else {
                    let mainDataImageView = UIImageView()
                    let mainDataImage = UIImage(data: mainData[i].mainImage!)
                    mainDataImageView.image = mainDataImage
                    
                    let item: InstagramData = InstagramData(mainImage: mainDataImageView, mainText: mainData[i].mainText, likeText: mainData[i].likeText, dateText: mainData[i].dateText)
                    
                    let userItem: UserData = UserData(mainImage: mainDataImageView)
                    list.append(item)
                    userList.append(userItem)
                }
            }
        } else {
            print("is zero..")
        }
    }
    
    fileprivate func deleteData(_ id: String) {
        CoreDataManager.shared.deleteData(id: id)
    }
    
    func checkAlbumPermission(){
            PHPhotoLibrary.requestAuthorization( { status in
                switch status {
                case .authorized:
                    print("Album: ?????? ??????")
                    
                case .denied:
                    print("Album: ?????? ??????")
                    
                case .restricted, .notDetermined:
                    print("Album: ???????????? ??????")
                    
                default:
                    break
                }
            })
    }
    
    func checkCameraPermission(){
           AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
               if granted {
                   print("Camera: ?????? ??????")
                   
               } else {
                   print("Camera: ?????? ??????")
               }
           })
    }
    
    @objc func editButtonAction(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: tableView)
        let myViewController = AddViewController()
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        editJudgeNumber = 1
        indexPathrowForEdit = indexPath.row
        
        myViewController.modalPresentationStyle = .fullScreen
        present(myViewController, animated: true, completion: nil)
    }

    @objc func deleteButtonAction(_ sender: UIButton) {
        let mainData: [MainDataEntity] = CoreDataManager.shared.getUsers()
        let point = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        let deletePopup = UIAlertController(title: "??????", message: "?????? ????????? ???????????? ????????? ??????????????????.\n????????? ?????????????????????????", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.default) { action in
            list.remove(at: indexPath.row) // 3
            userList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.deleteData(mainData[indexPath.row].dateText!)
        }
        
        let deleteCancelAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.default) { action in
            return
        }
        
        deletePopup.addAction(deleteAction)
        deletePopup.addAction(deleteCancelAction)

        present(deletePopup, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCustomCell", for: indexPath) as? MainViewCustomCell else { return UITableViewCell() }
        
        cell.mainText.text = list[indexPath.row].mainText
        cell.likeNumberText.text = list[indexPath.row].likeText
        cell.mainViewImage.image = list[indexPath.row].mainImage?.image
        cell.dateText.text = list[indexPath.row].dateText
        
        cell.selectionStyle = .none
        
        return cell
    }
}
