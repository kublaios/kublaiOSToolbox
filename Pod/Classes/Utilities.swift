//
//  Utilities.swift
//  kublaiOSToolbox
//
//  Created by Kubilay Erdogan on 13/06/15.
//  Copyright (c) 2015 Kubilay Erdogan
//

import Foundation

class Utilities {
    
    static func JSONDataFromURL(url: String) -> NSDictionary {
        var err: NSError
        var errPointer: NSErrorPointer = NSErrorPointer()
        var request: NSURLRequest = NSURLRequest(URL: NSURL(string: url) as NSURL!)
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:errPointer)!
        if let retDict: AnyObject = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: errPointer) {
            return retDict as! NSDictionary
        } else {
            return NSDictionary()
        }
    }
    
    static func formatURL(url: String, param1: String?, param2: String?) -> String {
        if param1 != nil {
            if param2 != nil {
                return NSString(format: url, param1 as NSString!, param2 as NSString!) as String
            } else {
                return NSString(format: url, param1 as NSString!) as String
            }
        } else {
            return ""
        }
    }
    
    static func Log(log: String!) {
        if true {
            println(log)
        }
    }
    
    static func t(string: String) -> String {
        // TODO: Implement localization
        return string
    }
    
    static func isHostReachable() -> Bool {
        // TODO: Implement Reachability dependency
        // return (Reachability(hostName: "google.com").currentReachabilityStatus() != NetworkStatus.NotReachable)
        return true
    }
    
    static func viewController(name: String, inStoryboard: UIStoryboard) -> UIViewController {
        return inStoryboard.instantiateViewControllerWithIdentifier(name) as! UIViewController
    }
    
}