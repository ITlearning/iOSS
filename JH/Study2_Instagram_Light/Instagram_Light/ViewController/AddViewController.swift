//
//  AddviewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/03.
//

import UIKit
import SnapKit

class AddViewController: UIViewController {
    let images = UIImageView()
    let picker = UIImagePickerController()
    
    lazy var mainTitleText: UILabel = {
        let mainTitleText = UILabel()
        
        if editJudgeNumber == 1 {
            mainTitleText.text = "게시글 수정"
            
        } else {
            mainTitleText.text = "피드 작성하기"
        }
        
        mainTitleText.textColor = UIColor.textColor
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
    
        return mainTitleText
    }()
    
    lazy var mainTextView: UITextView = {
        let mainTextView = UITextView()
        
        if editJudgeNumber == 1 {
            mainTextView.text = list[indexPathrowForEdit].mainText
            mainTextView.textColor = UIColor.textColor
        } else {
            mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
            mainTextView.textColor = .systemGray2
        }
        mainTextView.backgroundColor = UIColor.backgroundColor
        mainTextView.font = UIFont.systemFont(ofSize: 15)
        mainTextView.layer.borderWidth = 0.5
        mainTextView.layer.borderColor = UIColor.systemGray.cgColor
        mainTextView.textAlignment = .left
        mainTextView.delegate = self
        
        return mainTextView
    }()
    
    lazy var showChosenImage: UIImageView = {
        let showChosenImage = UIImageView()
        
        if editJudgeNumber == 1 {
            showChosenImage.image = list[indexPathrowForEdit].mainImage?.image
        } else {
            showChosenImage.image = UIImage(named: "showChosenImage")
            mainTextView.delegate = self
        }
        
        return showChosenImage
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    func configureLayout() {
        
        picker.delegate = self
        
        view.backgroundColor = UIColor.backgroundColor
            
        view.addSubview(mainTitleText)
        
        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        let cancelButton = UIButton()
        
        cancelButton.backgroundColor = UIColor.backgroundColor
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelButton.setTitleColor(.systemBlue, for: .normal)

        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-25)
        }
        
        let choosePictureButton = UIButton()
        
        choosePictureButton.backgroundColor = UIColor.backgroundColor
        choosePictureButton.setTitle("사진 선택하기", for: .normal)
        choosePictureButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        choosePictureButton.setTitleColor(.systemBlue, for: .normal)
        
        view.addSubview(choosePictureButton)
        
        choosePictureButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.leading.equalToSuperview().offset(150)
        }
        
        let showImageEdge = UILabel()
        
        showImageEdge.font = UIFont.boldSystemFont(ofSize: 35)
        showImageEdge.textColor = .darkGray
        showImageEdge.layer.borderWidth = 1
        showImageEdge.layer.borderColor = UIColor.darkGray.cgColor
        showImageEdge.textAlignment = .center
        
        view.addSubview(showImageEdge)
            
        showImageEdge.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(CGSize(width: 400, height: 350))
        }
        
        view.addSubview(showChosenImage)
            
        showChosenImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(CGSize(width: 400, height: 350))
        }
        
        view.addSubview(mainTextView)
        
        mainTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(499)
            make.leading.equalToSuperview().offset(-1)
            make.size.equalTo(CGSize(width: 400, height: 150))
        }
        
        let saveButton = UIButton()
        
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveButton.backgroundColor = .systemBlue
        
        saveButton.layer.cornerRadius = 5
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(670)
            make.leading.equalToSuperview().offset(95)
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        
        saveButton.addTarget(self, action:#selector(self.saveButtonAction), for: .touchUpInside)
        cancelButton.addTarget(self, action:#selector(self.cancelButtonAction), for: .touchUpInside)
        choosePictureButton.addTarget(self, action:#selector(self.choosePictureButtonAction), for: .touchUpInside)
    }
    
    fileprivate func saveNewUser(mainImage: Data, mainText: String, likeText: String, dateText: String) {
        
        if (likeText == "") {
            print("saved = Fail")
        } else {
            CoreDataManager.shared.saveUser(mainImage: mainImage, mainText: mainText, likeText: likeText, dateText: dateText) { onSuccess in
                print("saved = \(onSuccess)")
            }
        }
    }
    
    fileprivate func deleteData(_ id: String) {
        CoreDataManager.shared.deleteData(id: id)
    }
    
    @objc func cancelButtonAction() {
        self.presentingViewController?.dismiss(animated: true)
        editJudgeNumber = 0
    }
    
    @objc func saveButtonAction() {
        
        if editJudgeNumber == 1 {
            images.image = self.showChosenImage.image
            
            let popup = UIAlertController(title: "알림", message: "수정하시겠습니까?", preferredStyle: .alert)
            
            let rightAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
                let text1 = self.mainTextView.text ?? ""
                let image1 = UIImageView()
                image1.image = self.images.image ?? nil
                
                let item: InstagramData = InstagramData(mainImage: image1, mainText: text1, likeText: list[indexPathrowForEdit].likeText, dateText: list[indexPathrowForEdit].dateText)
                let userItem: UserData = UserData(mainImage: image1)
                
                if (self.mainTextView.text == "") || (image1.image == nil) {
                    let error = UIAlertController(title: "경고", message: "이미지가 없습니다!", preferredStyle: .alert)
                    let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    
                    error.addAction(okalert)
                    
                    self.present(error, animated: true, completion: nil)
                    
                } else if ((self.mainTextView.textColor == .systemGray2) &&  (self.mainTextView.text == "이곳에 사진과 함께 적을 글을 입력해주세요!")) {
                    let error = UIAlertController(title: "경고", message: "내용이 없습니다!", preferredStyle: .alert)
                    let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    
                    error.addAction(okalert)
                    
                    self.present(error, animated: true, completion: nil)
                    
                } else {
                    let users: [MainDataEntity] = CoreDataManager.shared.getUsers()
                    let finalPopup = UIAlertController(title: "알림", message: "성공적으로 수정되었습니다!", preferredStyle: .alert)
                    let setEndAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
                        self.saveNewUser(mainImage: (image1.image?.jpegData(compressionQuality: 1.0))!, mainText: text1, likeText: list[indexPathrowForEdit].likeText!, dateText: list[indexPathrowForEdit].dateText!)
                        
                        list.remove(at: indexPathrowForEdit)
                        userList.remove(at: indexPathrowForEdit)
                        self.deleteData(users[indexPathrowForEdit].dateText!)
                        
                        userList.insert(userItem, at: indexPathrowForEdit)
                        list.insert(item, at: indexPathrowForEdit)
                        
                        self.showChosenImage.image = UIImage(named: "showChosenImage")
                        self.images.image = nil
                        self.mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
                        self.mainTextView.textColor = .systemGray2
                        
                        editJudgeNumber = 0
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    finalPopup.addAction(setEndAction)
                    
                    self.present(finalPopup, animated: true, completion: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
            
            popup.addAction(rightAction)
            popup.addAction(cancelAction)
            
            self.present(popup, animated: true, completion: nil)
            
        } else {
            
            let popup = UIAlertController(title: "알림", message: "저장하시겠습니까?", preferredStyle: .alert)
            
            let rightAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
                let randomData = Int.random(in: 0...9999999999)
                let text1 = self.mainTextView.text ?? ""
                let image1 = UIImageView()
                let currentDate = self.testMain()
                image1.image = self.images.image ?? nil
        
                let item: InstagramData = InstagramData(mainImage: image1, mainText: text1, likeText: String(randomData), dateText: currentDate)
                let userItem: UserData = UserData(mainImage: image1)
                
                if (self.mainTextView.text == "") || (image1.image == nil) {
                    let error = UIAlertController(title: "경고", message: "이미지가 없습니다!", preferredStyle: .alert)
                    let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    
                    error.addAction(okalert)
                    
                    self.present(error, animated: true, completion: nil)
                    
                } else if ((self.mainTextView.textColor == .systemGray2) &&  (self.mainTextView.text == "이곳에 사진과 함께 적을 글을 입력해주세요!")) {
                    let error = UIAlertController(title: "경고", message: "내용이 없습니다!", preferredStyle: .alert)
                    let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                    
                    error.addAction(okalert)
                    
                    self.present(error, animated: true, completion: nil)
                    
                } else {

                    let finalPopup = UIAlertController(title: "알림", message: "성공적으로 저장되었습니다!", preferredStyle: .alert)
                    let setEndAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
                        userList.insert(userItem, at: 0)
                        list.insert(item, at: 0)
                        
                        self.showChosenImage.image = UIImage(named: "showChosenImage")
                        self.images.image = nil
                        self.mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
                        self.mainTextView.textColor = .systemGray2
                        
                        self.saveNewUser(mainImage: (image1.image?.jpegData(compressionQuality: 1.0))!, mainText: text1, likeText: String(randomData) , dateText: currentDate)
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    finalPopup.addAction(setEndAction)
                    
                    self.present(finalPopup, animated: true, completion: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default)
            
            popup.addAction(rightAction)
            popup.addAction(cancelAction)
            
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc func choosePictureButtonAction() {
        let openCameraOrLibraryAlert = UIAlertController(title: "사진 선택하기", message: userName + "님 소중한 추억을 찍거나 꺼내보세요", preferredStyle: .actionSheet)
        let libraryAlertAction = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()}
        let cameraAlertAction = UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera()}
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        openCameraOrLibraryAlert.addAction(libraryAlertAction)
        openCameraOrLibraryAlert.addAction(cameraAlertAction)
        openCameraOrLibraryAlert.addAction(cancelAlertAction)
        
        present(openCameraOrLibraryAlert, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        
        present(picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        picker.sourceType = .camera
        
        present(picker, animated: false, completion: nil)
    }
    
    func testMain() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date_string = dateFormatter.string(from: nowDate)
        
        return date_string
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension AddViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            images.image = image
            showChosenImage.image = image
            
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ mainTextView: UITextView) {
        guard mainTextView.textColor == .systemGray2 else { return }
        mainTextView.textColor = .black
        mainTextView.text = nil
    }
    func textViewDidEndEditing(_ mainTextView: UITextView) {
        if mainTextView.text.isEmpty {
            mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
            mainTextView.textColor = .systemGray2
        }
    }
}
