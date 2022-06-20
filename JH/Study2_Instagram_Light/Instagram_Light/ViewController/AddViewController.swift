//
//  AddviewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/03.
//

import UIKit
import SnapKit
import SwiftUI

@available(iOS 13.0.0, *)
struct AddViewPreview: PreviewProvider {
    static var previews: some View {
        AddViewControllerRepresentable()
    }
}

struct AddViewControllerRepresentable:UIViewControllerRepresentable {
    typealias UIViewControllerType = AddViewController
    
    func makeUIViewController(context: Context) -> AddViewController {
        
        return AddViewController()
    }
    
    func updateUIViewController(_ uiViewController: AddViewController, context: Context) {}
}

class AddViewController: UIViewController {
    
    let images = UIImageView()
    let picker = UIImagePickerController()
    
    lazy var mainTextView: UITextView = {
        let mainTextView = UITextView()
        mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
        mainTextView.textColor = .placeholderText
        mainTextView.font = UIFont.systemFont(ofSize: 15)
        mainTextView.layer.borderWidth = 0.5
        mainTextView.layer.borderColor = UIColor.systemGray.cgColor
        mainTextView.textAlignment = .left
        mainTextView.delegate = self
        
        return mainTextView
    }()
    
    lazy var showChosenImage: UIImageView = {
        let showChosenImage = UIImageView()
        showChosenImage.image = UIImage(named: "showChosenImage")
        mainTextView.delegate = self
        
        return showChosenImage
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.mainTextView.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    func configureLayout() {
        
        picker.delegate = self
        
        view.backgroundColor = .white
        
        let supergreen = UIColor(named: "jaehyeokcolor1")
        
        let mainTitleText = UILabel()
        
        mainTitleText.text = "피드 남기기"
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTitleText)
        
        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        let cancelButton = UIButton()
        
        cancelButton.backgroundColor = .white
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelButton.setTitleColor(.systemBlue, for: .normal)

        view.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-25)
        }
        
        let choosePictureButton = UIButton()
        
        choosePictureButton.backgroundColor = .white
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
            make.leading.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.size.equalTo(CGSize(width: 400, height: 300))
        }
        
        view.addSubview(showChosenImage)
            
        showChosenImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.leading.equalToSuperview().offset(-1)
            make.right.equalToSuperview().offset(1)
            make.size.equalTo(CGSize(width: 400, height: 300))
        }
        
        view.addSubview(mainTextView)
        
        mainTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(449)
            make.leading.equalToSuperview().offset(-1)
            make.right.equalToSuperview().offset(1)
            make.size.equalTo(CGSize(width: 400, height: 150))
        }
        
        let saveButton = UIButton()
        
        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        saveButton.backgroundColor = supergreen
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(650)
            make.leading.equalToSuperview().offset(100)
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        
        saveButton.addTarget(self, action:#selector(self.saveButtonAction), for: .touchUpInside)
        
        choosePictureButton.addTarget(self, action:#selector(self.choosePictureButtonAction), for: .touchUpInside)
    }
    
    // 저장 버튼 액션. Alert사용.
    @objc func saveButtonAction() {
        let popup = UIAlertController(title: "알림", message: "저장하시겠습니까?", preferredStyle: .alert)
        
        let rightAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
            let randomData = Int.random(in: 0...10)
            let text1 = self.mainTextView.text ?? ""
            let image1 = UIImageView()
            let currentDate = self.testMain()
            image1.image = self.images.image ?? nil
            
            let item: InstagramData = InstagramData(mainImage: image1, mainTexts: text1, like: String(randomData), upLoadDate: currentDate)
            let userItem: UserData = UserData(mainImage: image1)
            
            if (self.mainTextView.text == "") || (image1.image == nil) {
                let error = UIAlertController(title: "경고", message: "이미지가 없습니다!", preferredStyle: .alert)
                let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                
                error.addAction(okalert)
                
                self.present(error, animated: true, completion: nil)
                
            } else if ((self.mainTextView.textColor == .placeholderText) &&  (self.mainTextView.text == "이곳에 사진과 함께 적을 글을 입력해주세요!")) {
                let error = UIAlertController(title: "경고", message: "내용이 없습니다!", preferredStyle: .alert)
                let okalert = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
                
                error.addAction(okalert)
                
                self.present(error, animated: true, completion: nil)
                
            } else {

                let finalPopup = UIAlertController(title: "알림", message: "성공적으로 저장되었습니다!", preferredStyle: .alert)
                let setEndAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
                    userList.append(userItem)
                    list.append(item)
                    
                    self.showChosenImage.image = UIImage(named: "showChosenImage")
                    self.images.image = nil
                    self.mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
                    self.mainTextView.textColor = .placeholderText
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
    
    // 오픈 카메라 & 앨범
    @objc func choosePictureButtonAction() {
        let openCameraOrLibraryAlert = UIAlertController(title: "사진 선택하기", message: userName + "님 소중한 추억을 찍거나 꺼내보세요", preferredStyle: .actionSheet)
//        let openCameraOrLibraryAlert = UIAlertController(title: "알림", message: "저장하시겠습니까?", preferredStyle: .alert)
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
        // [date 객체 사용해 현재 날짜 및 시간 24시간 형태 출력 실시]
        let nowDate = Date() // 현재의 Date 날짜 및 시간
        let dateFormatter = DateFormatter() // Date 포맷 객체 선언
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // Date 포맷 타입 지정
        
        let date_string = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
        
        return date_string
    }
    
    // 화면 아무데나 클릭하면 키보드가 내려감.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

// 내용 혹은 이미지가 없을 경우를 대비한 경고 팝업
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
        guard mainTextView.textColor == .placeholderText else { return }
        mainTextView.textColor = .black
        mainTextView.text = nil
    }
    func textViewDidEndEditing(_ mainTextView: UITextView) {
        if mainTextView.text.isEmpty {
            mainTextView.text = "이곳에 사진과 함께 적을 글을 입력해주세요!"
            mainTextView.textColor = .placeholderText
        }
    }
}
