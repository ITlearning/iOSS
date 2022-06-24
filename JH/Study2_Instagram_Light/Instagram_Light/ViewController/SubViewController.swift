//
//  SubViewController.swift
//  Instagram_Light
//
//  Created by Jaehyeok Lim on 2022/06/24.
//

public var indexPathForSubView: Int = 0

import UIKit
import SnapKit

class SubViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        
        tableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func configureLayout() {
        let mainTitleText = UILabel()
        
        view.backgroundColor = UIColor.backgroundColor
        
        mainTitleText.text = "CloneStagram"
        mainTitleText.textColor = .black
        mainTitleText.font = UIFont.boldSystemFont(ofSize: 30)
        mainTitleText.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainTitleText)

        mainTitleText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        let subViewCancelButton = UIButton()
        subViewCancelButton.setTitle("닫기", for: .normal)
        subViewCancelButton.setTitleColor(.systemBlue, for: .normal)
        subViewCancelButton.setTitleColor(.darkGray, for: .selected)
        subViewCancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(subViewCancelButton)
        
        subViewCancelButton.snp.makeConstraints { make in
            make.top.equalTo(mainTitleText).offset(2)
            make.leading.equalToSuperview().offset(330)
        }
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(SubViewCustomCell.self, forCellReuseIdentifier: "SubViewCustomCell")
        
        tableView.backgroundColor = UIColor.backgroundColor
        
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.right.bottom.equalToSuperview()
        }
     
        subViewCancelButton.addTarget(self, action: #selector(SubViewCancelbuttonAction), for: .touchUpInside)
    }
    
    fileprivate func deleteData(_ id: String) {
        CoreDataManager.shared.deleteData(id: id)
    }
    
    @objc func SubViewCancelbuttonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func editButtonAction(_ sender: UIButton) {
        let myViewController = AddViewController()

        editJudgeNumber = 1
        indexPathrowForEdit = indexPathForSubView
        
        myViewController.modalPresentationStyle = .fullScreen
        present(myViewController, animated: true, completion: nil)
    }
    
    @objc func deleteButtonAction(_ sender: UIButton) {
        let mainData: [MainDataEntity] = CoreDataManager.shared.getUsers()

        let deletePopup = UIAlertController(title: "주의", message: "한번 삭제한 데이터는 복구가 불가능합니다.\n정말로 삭제하시겠습니까?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { action in
            list.remove(at: indexPathForSubView) // 3
            userList.remove(at: indexPathForSubView)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic) //4
            self.deleteData(mainData[indexPathForSubView].dateText!)
            
            self.dismiss(animated: true, completion: nil)
        }
        
        let deleteCancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.default) { action in
            return
        }
        
        deletePopup.addAction(deleteAction)
        deletePopup.addAction(deleteCancelAction)

        present(deletePopup, animated: true, completion: nil)
    }
}

extension SubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubViewCustomCell", for: indexPath) as? SubViewCustomCell else { return UITableViewCell() }
        let mainData: [MainDataEntity] = CoreDataManager.shared.getUsers()
        
        let subViewImageView = UIImageView()
        let subViewImage = UIImage(data: mainData[indexPathForSubView].mainImage!)
        
        subViewImageView.image = subViewImage
        
        cell.mainText.text = mainData[indexPathForSubView].mainText
        cell.likeNumberText.text = mainData[indexPathForSubView].likeText
        cell.mainViewImage.image = subViewImageView.image
        cell.dateText.text = mainData[indexPathForSubView].dateText
        
        cell.selectionStyle = .none
        
        return cell
    }
}
