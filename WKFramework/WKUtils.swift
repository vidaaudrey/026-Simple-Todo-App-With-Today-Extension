//
//  Utils.swift
//  Apple Watch App
//
//  Created by Audrey Li on 5/10/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

public class WKUtils {
    
    public class func getGooglePlaceSearchString(lan: String = "-33.8670522", lng: String = "151.1957362", radius:String = "500", types:String = "", name:String = "", keyword: String, language:String = "") -> String {
        let radiusStr = radius == "" ? "" : "&radius=\(radius)"
        let languageStr = language == "" ? "" : "&language=\(language)"
        let typesStr = types == "" ? "" : "&types=\(types)"
        let nameStr = name == "" ? "" : "&name=\(name)"
        let keywordStr = keyword == "" ? "" : "&keyword=\(keyword)"
        
        return "\(WKConfig.GooglePlaceAPIURLPrefix)\(lan),\(lng)\(radiusStr)\(languageStr)\(typesStr)\(nameStr)\(keywordStr)&key=\(WKConfig.GooglePlaceServerAPIKey)"
    }
    
    public class func getGooglePlaceGetPlaceByIDURL(id:String, language:String = "en") -> String{
        let languageStr = language == "en" ? "" : "&language=\(language)"
         return "\(WKConfig.GooglePlaceGetPlaceByIDURLPrefix)\(id)&key=\(WKConfig.GooglePlaceServerAPIKey)"
    }
    public class func getGooglePlacePhotoURL(photoReference: String) -> String {
        return "\(WKConfig.GooglePlacePhotoURLPrefix)\(photoReference)&key=\(WKConfig.GooglePlaceServerAPIKey)"
    }
    
    //store information in UserDefaults
    public class func setObjectForKeyInUserDefaults(object: AnyObject, key:String, isGroupStorage: Bool = true){
        var defaults:NSUserDefaults?
        if isGroupStorage {
            defaults = NSUserDefaults(suiteName: WKConfig.NSUserDefaultSuiteName)
        } else {
            defaults = NSUserDefaults.standardUserDefaults()
        }
        defaults?.setObject(object, forKey: key)
        defaults?.synchronize()
    }
    
    //get information from UserDefaults
    public class func getObjectByKeyInUserDefaults(key: String, isGroupStorage: Bool = true) -> AnyObject? {
        var defaults:NSUserDefaults?
        if isGroupStorage {
            defaults = NSUserDefaults(suiteName: WKConfig.NSUserDefaultSuiteName)
        } else {
            defaults = NSUserDefaults.standardUserDefaults()
        }
        return defaults?.objectForKey(key)
    }
    
    
    public class func getNSURLByFileName(name: String, fileExtension: String) -> NSURL? {
        if let path =  NSBundle.mainBundle().pathForResource(name, ofType: fileExtension) {
            return NSURL(fileURLWithPath: path)
        } else {
            return nil
        }
    }
    
    public class func getStringFromURL(url: String, callback:((data:String) -> Void)) {
        let url = NSURL(string: url)!
        let task  = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
               println("error getting the data at getStringFromURL()")
            } else {
                callback(data: NSString(data: data, encoding: NSUTF8StringEncoding) as! String)
            }
        })
         task.resume()
    }
    
    public class func getDataFromURL(url: String, callback:((data:NSData) -> Void)) {
        let url = NSURL(string: url)!
        let task  = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println("error getting the data at getDataFromURL()")
            } else {
                callback(data: data)
            }
        })
        task.resume()
    }
    
    public class func getJSONObjectFromURL(url: String, callback:((jsonData:AnyObject) -> Void)){
        var nsURL = NSURL(string: url)!
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(nsURL, completionHandler: { data, response, error -> Void in
            if error != nil {
                println("error getting the data at getJSONObjectFromURL()")
            } else {
                if let jsonData: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) {
                    callback(jsonData: jsonData)
                }
            }
        })
        task.resume()
    }
    
    public class func getJSONObjectFromURLWithRequest(url: String, callback:((jsonData:AnyObject) -> Void)){
        var nsURL = NSURL(string: url)!
        let request = NSMutableURLRequest(URL: nsURL)
        var session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                println("error getting the data at getJSONObjectFromURL()")
            } else {
                if let jsonData: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) {
                    callback(jsonData: jsonData)
                }
            }
        })

        task.resume()
    }
    
    
    public class func getImageDataFromURL1(url: String, callback:((NSData?) -> Void)!){
        let downloadQueue = dispatch_queue_create("com.shomigo.processsdownload", nil)
        dispatch_async(downloadQueue) {
            
            var data = NSData(contentsOfURL: NSURL(string: url)!)
            callback(data)

        }
        
    }
    
    public class func getImageFromURLAndSave(url: String, localName:String, callback:((UIImage?) -> Void)) {
        
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        let destinationPath = documentsPath.stringByAppendingPathComponent(localName)
        
        var fileManager = NSFileManager.defaultManager()
        
        if fileManager.fileExistsAtPath(destinationPath) {
            
            callback(UIImage(contentsOfFile: destinationPath))
          
        } else {
            getDataFromURL(url, callback: { (data) -> Void in
                let image = UIImage(data: data)
                UIImagePNGRepresentation(image).writeToFile(destinationPath, atomically: true)
                callback(image)
            })
        }
        
    }
    
    
    class func getStringFromJSON(data: NSDictionary, key: String) -> String{
        
        let info : AnyObject? = data[key]
        
        if let info = data[key] as? String {
            return info
        }
        return ""
    }
    
    class func stripHTML(str: NSString) -> String {
        
        var stringToStrip = str
        var r = stringToStrip.rangeOfString("<[^>]+>", options:.RegularExpressionSearch)
        while r.location != NSNotFound {
            
            stringToStrip = stringToStrip.stringByReplacingCharactersInRange(r, withString: "")
            r = stringToStrip.rangeOfString("<[^>]+>", options:.RegularExpressionSearch)
        }
        
        return stringToStrip as String
    }
    
    class func formatDate(dateString: String) -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = formatter.dateFromString(dateString)
        
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.stringFromDate(date!)
    }
}
