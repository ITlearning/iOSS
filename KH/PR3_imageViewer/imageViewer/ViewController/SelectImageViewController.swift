//
//  SelectImageViewController.swift
//  imageViewer
//
//  Created by ROLF J. on 2022/06/28.
//

import UIKit
import SnapKit

class SelectImageViewController: UIViewController {
    
    @objc let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    let indexingLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.textColor = .white
        return label
    }()
    
    let imageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemGray5
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectImageViewLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    func selectImageViewLayout() {
        view.backgroundColor = .black
        
        view.addSubview(dismissButton)
        view.addSubview(indexingLabel)
        view.addSubview(imageScrollView)
        
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        dismissButton.addTarget(self, action: #selector(dismissToMain), for: .allEvents)
        
        indexingLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
        }
        
        imageScrollView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(((view.frame.width)/16)*9)
        }
    }
    
    @objc func dismissToMain() {
        self.dismiss(animated: true, completion: nil)
    }

}
