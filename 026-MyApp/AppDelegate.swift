//
//  AppDelegate.swift
//  026-Today-Extension
//
//  Created by Audrey Li on 5/21/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

/* This is an extenstion on the String class that can convert a given
string with the format of %d-%d into an NSIndexPath */
extension String{
    func toIndexPath () -> NSIndexPath{
        let components = self.componentsSeparatedByString("-")
        if components.count == 2{
            let section = components[0]
            let row = components[1]
            if let sectionValue = section.toInt(){
                if let rowValue = row.toInt(){
                    return NSIndexPath(forRow: rowValue, inSection: sectionValue)
                }
            }
        }
        return NSIndexPath()
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let widgetUrlScheme = "widget"
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        if url.scheme == widgetUrlScheme {
            // go through the extnesion to convert String to NSIndexPath 
            let indexPath = url.host!.toIndexPath()
            
            let navigationController = self.window!.rootViewController as! UINavigationController
            let controller = navigationController.topViewController as! TodoTableViewController
            controller.selectedIndexPath = indexPath
            controller.performSegueWithIdentifier("showDetail", sender: controller)
            println(indexPath)
        }
        return true 
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

