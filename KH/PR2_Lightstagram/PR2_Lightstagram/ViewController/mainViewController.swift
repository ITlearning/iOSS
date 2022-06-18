//
//  ViewController.swift
//  PR2_Lightstagram
//
//  Created by ROLF J. on 2022/06/14.
//

import UIKit
import SnapKit
import CoreData

class mainViewController: UIViewController {
    
    var container: NSPersistentContainer!
    
    var feedCount = [NSManagedObject]()
    
    private let feedTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var mainFeedButton = UIButton()
    var feedAddEditButton = UIButton()
    var userProfileButton = UIButton()
    
    // Add/Edit ViewController로 넘어가는 함수. 우선 automatic으로.
    @objc func clickAEB(_ sender: UIButton) {
        print("Checking")
        let addEditVC = addEditViewController()
        addEditVC.modalPresentationStyle = .automatic
        self.present(addEditVC, animated: true)
    }
    
    // userProfile ViewController로 넘어가는 함수. Fullscreen으로 넘어가버림.
    @objc func clickuPB(_ sender: UIButton) {
        let userProfileVC = userProfileViewController()
        userProfileVC.modalPresentationStyle = .fullScreen
        self.present(userProfileVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedTableView.dataSource = self
        self.feedTableView.delegate = self
        
        // Main 화면 배경색 설정
        view.backgroundColor = .white
        
        feedTableView.register(newFeedTableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        // Main 화면(피드 화면)의 제목(TextLabel)
        let userViewTitle = UILabel()
        userViewTitle.text = "Lightstagram"
        userViewTitle.font = UIFont.boldSystemFont(ofSize: 30.0)
        self.view.addSubview(userViewTitle)
        userViewTitle.snp.makeConstraints { make in
            make.width.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.height.equalTo(70)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        // 하단부, 버튼들이 들어갈 공간을 UIView로 설정하고 Background color 지정
        let naviButtonBar = UIView()
        self.view.addSubview(naviButtonBar)
        naviButtonBar.backgroundColor = .lightGray
        naviButtonBar.snp.makeConstraints { make in
            make.width.bottom.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        // feed들을 보여줄 tableView 공간 설정
        self.view.addSubview(feedTableView)
        feedTableView.backgroundColor = .gray
        feedTableView.snp.makeConstraints { make in
            make.width.equalTo(self.view)
            make.top.equalTo(userViewTitle.snp.bottom)
            make.bottom.equalTo(naviButtonBar.snp.top)
        }
        
        // mainFeedButton
        var mainConfig = UIButton.Configuration.plain()
        mainConfig.image = UIImage(systemName: "house.fill")
        mainFeedButton.configuration = mainConfig
        self.view.addSubview(mainFeedButton)
        mainFeedButton.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        // feedAddEditButton
        var addEditConfig = UIButton.Configuration.plain()
        addEditConfig.image = UIImage(systemName: "plus.rectangle")
        feedAddEditButton.configuration = addEditConfig
        feedAddEditButton.tintColor = .green
        self.view.addSubview(feedAddEditButton)
        feedAddEditButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        feedAddEditButton.addTarget(self, action: #selector(clickAEB(_:)), for: .touchUpInside)

        // userProfileButton
        var userConfig = UIButton.Configuration.plain()
        userConfig.image = UIImage(systemName: "person.fill")
        userProfileButton.configuration = userConfig
        userProfileButton.tintColor = .gray
        self.view.addSubview(userProfileButton)
        userProfileButton.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-60)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        userProfileButton.addTarget(self, action: #selector(clickuPB(_:)), for: .touchUpInside)
    }

}

extension mainViewController: UITableViewDelegate {

}

extension mainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedCount.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? newFeedTableViewCell else { return UITableViewCell() }

        return cell
    }
}
