//
//  AddTaskController.swift
//  todoList
//
//  Created by Athena Javier on 10/20/18.
//  Copyright © 2018 Athena Javier. All rights reserved.
//


import UIKit

protocol AddTask {
    func addTask(name: String)
}

class AddTaskController: UIViewController {
    
    @IBAction func addAction(_ sender: Any) {
        if nameTextField.text != "" {
            delegate?.addTask(name: nameTextField.text!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: AddTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
