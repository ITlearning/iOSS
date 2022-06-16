//
//  AddviewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/03.
//

import UIKit
import SnapKit
import SwiftUI

/* Swift UI를 UIKit 안에서 사용할 코드들 (12번 라인부터 28번라인까지)*/
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
    
    func updateUIViewController(_ uiViewController: AddViewController, context: Context) {
    }
}

class AddViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray /* Self는 사용하지말자! */
        
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 100))
        
        label.text = "second"
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
