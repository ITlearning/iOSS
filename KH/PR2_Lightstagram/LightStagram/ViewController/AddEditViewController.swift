//
//  AddEditViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit
import SnapKit

class AddEditViewController: UIViewController {
    
    let placeHolderText = "사진과 함께 적을 글을 입력해주세요!"
    
    let imagePicker = UIImagePickerController()
    var newFeedImageView = UIImageView()
    var newFeedImageIfNilLabel = UILabel()
    lazy var newFeedTextView: UITextView = {
        let newFeedTextView = UITextView()
        newFeedTextView.text = placeHolderText
        newFeedTextView.textColor = .placeholderText
        newFeedTextView.font = UIFont.systemFont(ofSize: 15)
        newFeedTextView.delegate = self
        return newFeedTextView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // AddEditView에서는 탭바를 숨기도록 설정
//        self.tabBarController?.tabBar.isHidden = true
        
        imagePicker.delegate = self

        view.backgroundColor = .white
        showAddEditViewLayout()
        
    }
    
    // AddEditView의 화면 구성
    func showAddEditViewLayout() {
        // AddEditView의 타이틀
        let addEditViewTitle = UILabel()
        addEditViewTitle.text = "피드 남기기"
        addEditViewTitle.font = UIFont.boldSystemFont(ofSize: 30)
        addEditViewTitle.sizeToFit()
        view.addSubview(addEditViewTitle)
        addEditViewTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        // Feed 추가를 취소하는(이전 View로 돌아가는) 버튼
        let dismissMakeFeedButton = UIButton()
        dismissMakeFeedButton.configuration = UIButton.Configuration.plain()
        dismissMakeFeedButton.setTitle("취소", for: .normal)
        dismissMakeFeedButton.sizeToFit()
        view.addSubview(dismissMakeFeedButton)
        dismissMakeFeedButton.snp.makeConstraints { make in
            make.top.equalTo(addEditViewTitle.snp.centerY)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-5)
        }
        dismissMakeFeedButton.addTarget(self, action: #selector(pressDismissMakeFeedButton), for: .allEvents)
        
        // 이미지를 가져오는 "사진 선택하기" 버튼
        let getImageButton = UIButton()
        getImageButton.setTitle("사진 선택하기", for: .normal)
        getImageButton.configuration = UIButton.Configuration.plain()
        getImageButton.sizeToFit()
        view.addSubview(getImageButton)
        getImageButton.snp.makeConstraints { make in
            make.top.equalTo(addEditViewTitle.snp.bottom).offset(30)
            make.centerX.equalTo(view)
        }
        getImageButton.addTarget(self, action: #selector(getImageFunction), for: .allEvents)
        
        // 가져온 이미지를 보여줄 UIImageView
        view.addSubview(newFeedImageView)
        newFeedImageView.layer.borderWidth = 1
        newFeedImageView.layer.borderColor = UIColor.black.cgColor
        newFeedImageView.snp.makeConstraints { make in
            make.top.equalTo(getImageButton.snp.bottom)
            make.width.equalTo(view)
            make.height.equalTo(newFeedImageView.snp.width)
        }
        
        // UIImageView에 사진이 없으면 Label이 위에 보임 -> extension에 설정
        newFeedImageIfNilLabel.text = "사진을 선택해주세요!"
        newFeedImageIfNilLabel.textColor = .gray
        newFeedImageIfNilLabel.font = UIFont.boldSystemFont(ofSize: 40)
        newFeedImageIfNilLabel.textAlignment = .center
        view.addSubview(newFeedImageIfNilLabel)
        newFeedImageIfNilLabel.snp.makeConstraints { make in
            make.centerX.equalTo(newFeedImageView)
            make.centerY.equalTo(newFeedImageView)
        }
        
        // 새로운 Feed의 텍스트 입력 필드
        view.addSubview(newFeedTextView)
        newFeedTextView.layer.borderWidth = 1
        newFeedTextView.layer.borderColor = UIColor.black.cgColor
        newFeedTextView.snp.makeConstraints { make in
            make.top.equalTo(newFeedImageView.snp.bottom).offset(10)
            make.width.equalTo(view)
            make.height.equalTo(100)
        }
        
        // 새로운 Feed를 저장하는 버튼
        let saveNewFeedButton = UIButton()
        var saveNewFeedButtonConfiguration = UIButton.Configuration.filled()
        saveNewFeedButtonConfiguration.baseBackgroundColor = .green
        saveNewFeedButtonConfiguration.baseForegroundColor = .black
        saveNewFeedButton.configuration = saveNewFeedButtonConfiguration
        saveNewFeedButton.sizeToFit()
        view.addSubview(saveNewFeedButton)
        saveNewFeedButton.setTitle("저장하기", for: .normal)
        saveNewFeedButton.snp.makeConstraints { make in
            make.top.equalTo(newFeedTextView.snp.bottom).offset(70)
            make.centerX.equalTo(view)
        }
        saveNewFeedButton.addTarget(self, action: #selector(pressSaveButtonTest), for: .allEvents)
        
    }
    
    // 사진앨범을 여는 함수
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 카메라를 여는 함수
    func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 저장을 취소하고 이전 화면으로 돌아가는 취소 버튼의 함수
    @objc func pressDismissMakeFeedButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // getImageButton을 눌러 사진을 가져오는 함수
    @objc func getImageFunction() {
        let getImageSelectAlert = UIAlertController(title: "사진 가져오기", message: nil, preferredStyle: .actionSheet)
        let getImageWithLibrary = UIAlertAction(title: "앨범", style: .default) { _ in self.openLibrary() }
        let getImageWithCamera = UIAlertAction(title: "카메라", style: .default) { _ in self.openCamera() }
        let getImageCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        getImageSelectAlert.addAction(getImageWithLibrary)
        getImageSelectAlert.addAction(getImageWithCamera)
        getImageSelectAlert.addAction(getImageCancel)
        
        present(getImageSelectAlert, animated: true, completion: nil)
    }
    
    // 새로운 Feed를 CoreData에 저장하는 버튼
    @objc func pressSaveButtonTest() {
        if noFeedImage() == true && noFeedText() == true {
        saveToCoreData()
        clearAddEditView()
        }
    }
    
    // 업로드할 사진이 선택되지 않았으면 실행
    func noFeedImage() -> Bool {
        if newFeedImageView.image == nil {
            let noImageAlert = UIAlertController(title: "사진이 없습니다!", message: "사진을 선택해주세요!", preferredStyle: .alert)
            let checkButton = UIAlertAction(title: "OK", style: .default)
            noImageAlert.addAction(checkButton)
            present(noImageAlert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    // 업로드할 글이 작성되지 않았으면 실행
    func noFeedText() -> Bool {
        if newFeedTextView.text == placeHolderText || newFeedTextView.text == "" {
            let noTextAlert = UIAlertController(title: "글이 없습니다!", message: "사진과 함께 업로드할 글을 입력해주세요!", preferredStyle: .alert)
            let checkButton = UIAlertAction(title: "OK", style: .default)
            noTextAlert.addAction(checkButton)
            present(noTextAlert, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    // 랜덤 정수를 통해 likeCount 문자열을 만드는 함수
    func makeLikeCountString() -> String {
        let randLikeCount = Int.random(in: 0..<1000)
        let likeCountString = "\(randLikeCount)명이 좋아합니다."
        print(likeCountString)
        return likeCountString
    }
    
    // 업로드 시의 날짜 정보에 대한 문자열을 만드는 함수
    func makeUploadDateString() -> String {
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 hh:mm"
        let dateString = dateFormatter.string(from: nowDate)
        print(dateString)
        return dateString
    }
    
    // 저장 시 정보들을 CoreData에 저장하는 함수
    func saveToCoreData() {
        let newFeed = TableViewFeed(feedImage: newFeedImageView.image, feedText: newFeedTextView.text, likeCount: makeLikeCountString(), uploadDate: makeUploadDateString())
        let newFeedImageData = newFeed.feedImage?.jpegData(compressionQuality: 1)
        CoreDataManager.shared.saveFeed(feedImage: newFeedImageData!, feedText: newFeed.feedText ?? "", likeCount: newFeed.likeCount ?? "", uploadDate: newFeed.uploadDate ?? "")
        let mainViewController = MainViewController()
        mainViewController.refreshTableView()
    }
    
    // AddEditView를 초기화하는 함수
    func clearAddEditView() {
        newFeedImageView.image = nil
        newFeedTextView.text = nil
        textViewDidEndEditing(newFeedTextView)
        newFeedImageIfNilLabel.text = "사진을 선택해주세요!"
        
//        let clearAlert = UIAlertController(title: "저장되었습니다!", message: nil, preferredStyle: .alert)
//        let checkButton = UIAlertAction(title: "OK", style: .default)
//        clearAlert.addAction(checkButton)
//        present(clearAlert, animated: true, completion: nil)
        
        let SuccessAlert = UIAlertController(title: "등록성공", message: "등록이 성공되었습니다.\n등록 뷰를 닫으시겠습니까?", preferredStyle: .alert)
        let OKButton = UIAlertAction(title: "닫기", style: .default)
        let dismissButton = UIAlertAction(title: "아니오", style: .default)
        SuccessAlert.addAction(dismissButton)
        SuccessAlert.addAction(OKButton)
        present(SuccessAlert, animated: true, completion: nil)
        
        view.endEditing(true)
    }
    
    // 화면을 터치하면 키보드가 내려가는 함수
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 이미지를 가져올 때 UIImage 형식이 맞는지 확인하고 newFeedImageView에 출력함
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newFeedImageIfNilLabel.text = nil
            newFeedImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension AddEditViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard newFeedTextView.textColor == .placeholderText else { return }
        newFeedTextView.textColor = .black
        newFeedTextView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if newFeedTextView.text.isEmpty {
            newFeedTextView.text = placeHolderText
            newFeedTextView.textColor = .placeholderText
        }
    }
}
