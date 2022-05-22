//
//  ViewController.swift
//  Study3_TodoList_2
//
//  Created by Jaehyeok Lim on 2022/05/17.
//

import UIKit

var list = [TodoList]()

struct TodoList {
    var title: String = ""  // 할일 제목
    var content: String?    // 할일 세부 내용
    var isComplete: Bool = false  // 할일 완료 여부
 
    init(title: String, content: String?, isComplete: Bool = false) {
        self.title = title
        self.content = content
        self.isComplete = isComplete
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var todoListTableView: UITableView!
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
    
    @objc func doneButtonTap() {
        self.navigationItem.leftBarButtonItem = editButton
        todoListTableView.setEditing(false, animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
   
        guard !list.isEmpty else {
            return
        }

        self.navigationItem.leftBarButtonItem = doneButton
        todoListTableView.setEditing(true, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        list.remove(at: indexPath.row)
        todoListTableView.reloadData()
    }
    

    // 완료 체크 기능
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 이미 체크되있는 경우 return
        guard !list[indexPath.row].isComplete else {
            return
        }
     
        // 리스트 선택 시 완료된 할일 표시(checkmark)
        list[indexPath.row].isComplete = true
     
        let dialog = UIAlertController(title: "Todo List", message: "일을 완료했습니다!!!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertAction.Style.default)
        dialog.addAction(action)
        self.present(dialog, animated: true, completion: nil)
     
        todoListTableView.reloadData()
    }
    
    // userdefault 저장
       func saveAllData() {
           let data = list.map {
               [
                   "title": $0.title,  // $0 : 0번부터
                   "content": $0.content!,
                   "isComplete": $0.isComplete
               ]
           }
           
           print(type(of: data))
           let userDefaults = UserDefaults.standard
           userDefaults.set(data, forKey: "items")
           userDefaults.synchronize()
       }
       
       // userDefault 데이터 불러오기
       func loadAllData() {
           let userDefaults = UserDefaults.standard
           guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else {
               return
           }
           
           print(data.description)
           
           // list 배열에 저장하기
           print(type(of: data))
           list = data.map {
               var title = $0["title"] as? String
               var content = $0["content"] as? String
               var isComplete = $0["isComplete"] as? Bool
               
               return TodoList(title: title!, content: content!, isComplete: isComplete!)
           }
       }


    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllData()
        print(list.description)
        todoListTableView.delegate = self
        todoListTableView.dataSource = self
        doneButton.style = .plain
        doneButton.target = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        saveAllData()
        todoListTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].content
        
        if list[indexPath.row].isComplete {
            
            cell.accessoryType = .checkmark
            
        } else {
            
            cell.accessoryType = .none
            
        }
     
        return cell
    }
  
}
