//
//  ViewController.swift
//  todoList
//
//  Created by Athena Javier on 10/20/18.
//  Copyright © 2018 Athena Javier. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddTask, CheckBox {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [Tasks] = []
    var newTask : UITextField?
    var newText = ""


    func saveList(){
        let defaults = UserDefaults.standard
        defaults.set(tasks, forKey: "SavedList")
        print("***LIST SAVED!***")
    }
    
    //Retrieves default values saved
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let retrievedList = defaults.object(forKey: "SavedList")
        _ = retrievedList
        tableView.reloadData()
    }
    
    func tableView(_ _tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    //check mark
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        
        cell.taskNameLabel.text = tasks[indexPath.row].name
        
        if tasks[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage( #imageLiteral(resourceName: "check mark image"), for: UIControlState.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControlState.normal)
        }
        
        cell.delegate = self
        cell.tasks = tasks
        cell.indexP = indexPath.row
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddTaskController
        vc.delegate = self
    }
    
    func addTask(name: String) {
        tasks.append(Tasks(name: name))
        tableView.reloadData()
    }
    
    func editTask(textField: UITextField!){
        newTask = textField
    }
    
    func checkBox(state: Bool, index: Int?) {
        tasks[index!].checked = state
        tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.none)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) ->
        [UITableViewRowAction]? {
            
            func createAlert(title: String, message: String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
                    self.newText = (self.newTask?.text)!
                    self.tasks.remove(at: indexPath.row)
                    
                    self.tasks.insert(Tasks(name: self.newText), at: indexPath.row)
                    self.tableView.reloadData()
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
                }))
                
                alert.addTextField(configurationHandler: editTask)
                self.present(alert, animated: true, completion: nil)
            }
            
            let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexpath) in
                createAlert(title: "Edit", message: "Edit your task")
                print("Edit Clicked")
            }
            editButton.backgroundColor = UIColor.green
            
            let cancelButton = UITableViewRowAction(style: .normal, title: "Cancel") { (rowAction, indexpath) in
                print("Cancel Clicked")
            }
            editButton.backgroundColor = UIColor.yellow
            return[editButton,cancelButton]
            
    }
    
    
    
}


class Tasks {
    var name = ""
    var checked = false
    
    convenience init (name: String) {
        self.init()
        self.name = name
    }
}

