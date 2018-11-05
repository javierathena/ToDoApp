//
//  TaskCell.swift
//  todoList
//
//  Created by Athena Javier on 10/20/18.
//  Copyright © 2018 Athena Javier. All rights reserved.
//

import UIKit

protocol CheckBox {
    func checkBox(state: Bool, index: Int?)
}

class TaskCell: UITableViewCell {
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if tasks![indexP!].checked {
            delegate?.checkBox(state: false, index: indexP)
        } else {
            delegate?.checkBox(state: true, index: indexP)
        }
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var taskNameLabel: UILabel!
    
    var indexP: Int?
    var delegate: CheckBox?
    var tasks: [Tasks]?
}
