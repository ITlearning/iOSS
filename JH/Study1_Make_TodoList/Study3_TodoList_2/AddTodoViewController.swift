//
//  AddTodoViewController.swift
//  Study3_TodoList_2
//
//  Created by Jaehyeok Lim on 2022/05/17.
//

import UIKit

class AddTodoViewController: UIViewController {

    @IBAction func cancleButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBAction func doneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        let title = titleTextField.text!
        let content = contentTextView.text ?? ""
         
        let item: TodoList = TodoList(title: title, content: content)
         
        print("Add List title : \(item.title)")
        // TodoListViewController에 생성한 전역변수에 append
        list.append(item)
        
        self.navigationController?.popViewController(animated: true)

    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
     
            // Do any additional setup after loading the view.
            contentTextView.layer.borderColor = UIColor.gray.cgColor  // 테두리 색상
            contentTextView.layer.borderWidth = 0.3 // 테두리 두께
            contentTextView.layer.cornerRadius = 2.0  // 모서리 둥글게
            contentTextView.clipsToBounds = true  //
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
