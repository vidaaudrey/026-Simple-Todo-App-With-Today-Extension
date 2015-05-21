//
//  EditTodoViewController.swift
//  026-Today-Extension
//
//  Created by Audrey Li on 5/21/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit
import WKFramework

class EditTodoViewController: UIViewController {

    @IBOutlet weak var todoItemInput: UITextField!
    let keyName = WKConfig.TodoListAppUserDefaultKeyName
    var selectedIndex:Int = 0
    
   var todoItems:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todoItems = WKUtils.getObjectByKeyInUserDefaults(keyName) as! [String]
        todoItemInput.text = todoItems[selectedIndex]
    }
    
    @IBAction func saveTodoItemBtnPressed(sender: UIButton) {
        
        var newTodo = todoItemInput.text
        if !newTodo.isEmpty && newTodo != todoItems[selectedIndex]{
            todoItems.removeAtIndex(selectedIndex)
            todoItems.insert(newTodo, atIndex: selectedIndex)
        }
        WKUtils.setObjectForKeyInUserDefaults(todoItems, key: keyName)
        dismissViewControllerAnimated(true, completion: nil)

    }
    @IBAction func deleteBtnPressed(sender: UIButton) {
        todoItems.removeAtIndex(selectedIndex)
        WKUtils.setObjectForKeyInUserDefaults(todoItems, key: keyName)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
