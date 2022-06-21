//
//  ViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/05/26.
//

import UIKit
import SnapKit
import SwiftUI
import AVFoundation
import Photos

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

struct ViewControllerRepresentable:UIViewControllerRepresentable {
    typealias UIViewControllerType = MainViewController
    
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    }
}

class MainViewController: UIViewController {

    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        print("ViewController의 view가 화면에 나타남")
        if (self.tableView.contentSize.height > self.tableView.frame.size.height) {
            let offset = CGPoint(x: CGFloat(0), y: CGFloat(self.tableView.contentSize.height - self.tableView.frame.size.height))
            self.tableView.setContentOffset(offset, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCameraPermission()
        checkAlbumPermission()
        configureLayout()
    }
    
    func configureLayout() {
        let mainTitleText = UILabel()
        
        view.backgroundColor = .white
        
        mainTitleText.text = "CloneStagram"
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
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(-26)
            make.right.bottom.equalToSuperview().offset(0)
        }
    }

    func checkAlbumPermission(){
            PHPhotoLibrary.requestAuthorization( { status in
                switch status {
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
    
    func checkCameraPermission(){
           AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
               if granted {
                   print("Camera: 권한 허용")
                   
               } else {
                   print("Camera: 권한 거부")
               }
           })
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewCustomCell", for: indexPath) as? MainViewCustomCell else { return UITableViewCell() }
        
        cell.mainText.text = list[indexPath.row].mainTexts
        cell.likeText.text = list[indexPath.row].like
        cell.mainViewImage.image = list[indexPath.row].mainImage?.image
        cell.dateText.text = list[indexPath.row].upLoadDate
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete) {
            
            list.remove(at: indexPath.row)
            userList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
