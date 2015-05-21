//
//  TodoListInterfaceController.swift
//  Apple Watch App
//
//  Created by Audrey Li on 5/10/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import WatchKit
import Foundation
import WKFramework


class TodoListInterfaceController: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!
    
    var todoItems:[String] = []
    let keyName = WKConfig.TodoListAppUserDefaultKeyName

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let items:[String] = WKUtils.getObjectByKeyInUserDefaults(keyName) as?[String]{
            self.todoItems = items
            loadTableData()
        }
        
    }
    
    func loadTableData(){
        table.setNumberOfRows(todoItems.count, withRowType: "TableRowController")
        for (index, item) in enumerate(todoItems){
            let row = table.rowControllerAtIndex(index) as! TableRowController
            row.cellLabel.setText(item)
        }

    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        todoItems.removeAtIndex(rowIndex)
        WKUtils.setObjectForKeyInUserDefaults(todoItems, key: keyName)
        loadTableData()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
