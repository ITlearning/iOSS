//
//  addEditViewController.swift
//  PR2_Lightstagram
//
//  Created by ROLF J. on 2022/06/14.
//

import UIKit
import SnapKit
import CoreData

class addEditViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        // 화면 흰색으로 변경
        view.backgroundColor = .white
        
        // Add/Edit 화면의 제목
        let addEditViewTitle = UILabel()
        addEditViewTitle.text = "피드 남기기"
        addEditViewTitle.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.view.addSubview(addEditViewTitle)
        addEditViewTitle.snp.makeConstraints { make in
            make.width.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
//        // Back Button
//        var backConfig = UIButton.Configuration.plain()
//        backConfig.image = UIImage(systemName: "delete.backward")
//        backToMainButton.configuration = backConfig
//        self.view.addSubview(backToMainButton)
//        backToMainButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
//            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            make.width.equalTo(50)
//            make.height.equalTo(30)
//        }
        
        // 사진을 가져오기 Button
        let getImageButton = UIButton()
        let GIConfig = UIButton.Configuration.plain()
        getImageButton.setTitle("사진 선택하기", for: .normal)
        getImageButton.sizeToFit()
        getImageButton.configuration = GIConfig
        self.view.addSubview(getImageButton)
        getImageButton.snp.makeConstraints { make in
            make.top.equalTo(addEditViewTitle.snp.bottom)
            make.centerX.equalTo(self.view)
        }
        
        // 가져온 사진을 보여줄 ImageView
        var getImageView = UIImageView()
        self.view.addSubview(getImageView)
        getImageView.backgroundColor = .lightGray
        getImageView.snp.makeConstraints { make in
            make.top.equalTo(getImageButton.snp.bottom).offset(10)
            make.width.equalTo(self.view)
            make.height.equalTo(getImageView.snp.width)
        }
        
        if getImageButton.isSelected == true {
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
                
            }
        }
        
        // 사진과 함께 적을 텍스트를 가져올 TextField
        let getTextField = UITextField()
        getTextField.placeholder = "사진과 함께 저장할 글을 입력해주세요"
        getTextField.layer.borderWidth = 1.0
        getTextField.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(getTextField)
        getTextField.snp.makeConstraints { make in
            make.top.equalTo(getImageView.snp.bottom).offset(30)
            make.width.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.centerX.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        // Save Button
        let saveButton = UIButton()
        var saveConfig = UIButton.Configuration.plain()
        saveConfig.title = "Save"
        saveConfig.background.backgroundColor = .green
        saveButton.configuration = saveConfig
        saveButton.tintColor = .black
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(self.view)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        // If user click save button
        func clickSaveButton() {
            guard let feedContent = getTextField.text else {
                let alert = UIAlertController(title: "오류", message: "텍스트가 없습니다!", preferredStyle: .alert)
                let checkButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alert.addAction(checkButton)
                self.present(alert, animated: true)
                return
            }
            guard let feedImage = getImageView.image else {
                let alert = UIAlertController(title: "오류", message: "이미지가 없습니다!", preferredStyle: .alert)
                let checkButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alert.addAction(checkButton)
                self.present(alert, animated: true)
                return
            }
            let rand = Int.random(in: 0..<1000)
            let likeCount = rand
            let nowDate = Date()
            let newTempFeed = FeedModel(feedContent: feedContent, likeCount: likeCount, nowDate: nowDate, feedImage: feedImage)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Feed", in: context)
            
            // Save to Core Data Stack
            if let entity = entity {
                let feeds = NSManagedObject(entity: entity, insertInto: context)
                feeds.setValue(newTempFeed.feedContent, forKey: "feedContent")
                feeds.setValue(newTempFeed.likeCount, forKey: "likeCount")
                feeds.setValue(newTempFeed.nowDate, forKey: "nowDate")
                feeds.setValue(newTempFeed.feedImage, forKey: "feedImage")
                
                // Save Stack
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

extension addEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
