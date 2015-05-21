//
//  AddTodoViewController.swift
//  026-Today-Extension
//
//  Created by Audrey Li on 5/21/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit
import WKFramework

class AddTodoViewController: UIViewController {
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var todoItemInput: UITextField!
    let keyName = WKConfig.TodoListAppUserDefaultKeyName
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addTodoItemBtnPressed(sender: UIButton) {
        var todoItems:[String] = []
        if let currentItems:[String] = WKUtils.getObjectByKeyInUserDefaults(keyName) as? [String] {
            todoItems = currentItems
        }
        if todoItemInput.text != nil {
            todoItems.append(todoItemInput.text)
            WKUtils.setObjectForKeyInUserDefaults(todoItems, key: keyName)
            infoLabel.text = "Added a new todo: \(todoItemInput.text)"
            todoItemInput.text = ""
        }
    }

}
