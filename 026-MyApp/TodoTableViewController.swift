//
//  TodoTableViewController.swift
//  026-Today-Extension
//
//  Created by Audrey Li on 5/21/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit
import WKFramework

class TodoTableViewController: UITableViewController {

    @IBOutlet var editBtn: UIBarButtonItem!
    @IBOutlet var doneBtn: UIBarButtonItem!

    var selectedIndexPath:NSIndexPath?
    
    let keyName = WKConfig.TodoListAppUserDefaultKeyName
    var dataItems:[String] = [] {
        didSet {
            tableView.reloadData()
            WKUtils.setObjectForKeyInUserDefaults(dataItems, key: keyName)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool) {
        dataItems = WKUtils.getObjectByKeyInUserDefaults(keyName) as! [String]
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItems.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = dataItems[indexPath.row]
        return cell
    }
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataItems.removeAtIndex(indexPath.row)
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedIndexPath = indexPath
        performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let dvc = segue.destinationViewController as? EditTodoViewController {
                dvc.selectedIndex = selectedIndexPath!.row
            }
        }
    }

    @IBAction func toggleEditing(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.editing, animated: true)
        navigationItem.leftBarButtonItem = tableView.editing ? doneBtn : editBtn
    }


}
