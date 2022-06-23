//
//  MainViewController.swift
//  LightStagram
//
//  Created by ROLF J. on 2022/06/20.
//

import UIKit
import SnapKit

public let userName = "JKH"

class MainViewController: UIViewController {
    
    let mainViewTitle = UILabel()
    private let feedTableView: UITableView = {
        let feedTableView = UITableView()
        feedTableView.register(MainViewTableCustomCell.self, forCellReuseIdentifier: MainViewTableCustomCell.tableViewCellIdentifier)
        return feedTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewFunctions()
        showMainViewLayout()
    }
    
    func tableViewFunctions() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.rowHeight = 580
        feedTableView.reloadData()
        feedTableView.flashScrollIndicators()
    }
        
    // MainView의 화면 구성
    func showMainViewLayout() {
        view.backgroundColor = .white
        
        // MainView의 타이틀
        mainViewTitle.text = "LightStagram"
        mainViewTitle.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(mainViewTitle)
        mainViewTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-25)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(25)
        }
        
        showFeedTable()
    }
    
    // MainView의 테이블뷰
    func showFeedTable() {
        view.addSubview(feedTableView)
        feedTableView.snp.makeConstraints { make in
            make.top.equalTo(mainViewTitle.snp.bottom).offset(10)
            make.bottom.equalTo(view)
            make.width.equalTo(view)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let feedCell = tableView.dequeueReusableCell(withIdentifier: MainViewTableCustomCell.tableViewCellIdentifier, for: indexPath) as? MainViewTableCustomCell else { return UITableViewCell() }
        
        
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        <#code#>
    }
}
