//
//  addEditViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/16.
//

import UIKit

class addEditViewController: UIViewController {
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func imagePickerButton(_ sender: UIButton) {
        let imageAlert = UIAlertController(title: "사진 가져오기", message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "앨범", style: .default) { (action) in self.openLibrary() }
        let camera = UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        imageAlert.addAction(library)
        imageAlert.addAction(camera)
        imageAlert.addAction(cancel)
        
        present(imageAlert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var pickedImageVIew: UIImageView!
    
    @IBOutlet var editTextView: UITextView!
    
    @IBAction func clickDismiss(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickSaveButton(_ sender: UIButton) {
        let feedImage = self.pickedImageVIew.image?.jpegData(compressionQuality: 1)
        let feedText = self.editTextView.text
        let randInt = Int16.random(in: 0..<1000)
        let likeCount = randInt
        let nowDate = Date()
        
        let newFeed: FeedTemp = FeedTemp(feedImage: feedImage!, feedText: feedText ?? "", likeCount: likeCount, nowDate: nowDate)
        
        let giveToCoreDataManager = CoreDataManager()
        giveToCoreDataManager.insertFeed(newFeed)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTextView.layer.borderWidth = 1
        editTextView.layer.borderColor = UIColor.black.cgColor
        imagePicker.delegate = self
        pickedImageVIew.backgroundColor = .lightGray
        editTextView.layer.borderWidth = 1
        editTextView.layer.borderColor = UIColor.black.cgColor
    }
    
}

extension addEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImageVIew.image = image
            dismiss(animated: true, completion: nil)
        }
    }
}
