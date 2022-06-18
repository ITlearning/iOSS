//
//  ViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/05/26.
//

import UIKit
import SnapKit
import SwiftUI

/* Swift UI를 UIKit 안에서 사용할 코드들 (12번 라인부터 28번라인까지)*/
@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}

struct ViewControllerRepresentable:UIViewControllerRepresentable {
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGreen /* Self는 사용하지말자! */
        
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        
        label.text = "first"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .green
        label.sizeToFit()
        label.center.x = self.view.frame.width / 2
        
        self.view.addSubview(label)

        let mainTitleText = UILabel()
        mainTitleText.text = "CloneStagram"
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTitleText)
        
//        let safeArea = view.safeAreaLayoutGuide
//        mainTitleText.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        
        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
//            make.center.equalToSuperview()
        }
        
    }
}

