//
//  TodayViewController.swift
//  ALToday
//
//  Created by Audrey Li on 5/21/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit
import NotificationCenter
import WKFramework

class TodayViewController: UITableViewController, NCWidgetProviding {

    struct TableViewConstants{
        static let cellIdentifier = "Cell"
    }
    
    let keyName = WKConfig.TodoListAppUserDefaultKeyName
    var dataItems: [String] = []
    
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return dataItems.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(
                TableViewConstants.cellIdentifier,
                forIndexPath: indexPath) as! UITableViewCell
            
            cell.textLabel!.text = dataItems[indexPath.row]
            
            return cell
            
    }
    
    func resetContentSize(){
        self.preferredContentSize = tableView.contentSize
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        resetContentSize()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        resetContentSize()
    }
    
    func performFetch() -> NCUpdateResult{
        
        
//        for counter in 0..<arc4random_uniform(10){
//            dataItems.append("Item \(counter)")
//        }
    
        dataItems = WKUtils.getObjectByKeyInUserDefaults(keyName) as! [String]
        return .NewData
    }
    
    func widgetPerformUpdateWithCompletionHandler(
        completionHandler: ((NCUpdateResult) -> Void)!) {
            
            let result =  performFetch()
            if result == .NewData{
                tableView.reloadData()
                resetContentSize()
            }
            
            completionHandler(result)
    }
    
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let urlAsString = "widget://" + "\(indexPath.section)-\(indexPath.row)"
            let url = NSURL(string: urlAsString)
            self.extensionContext!.openURL(url!, completionHandler: nil)
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
}
