//
//  Extensions.swift
//  kublaiOSToolbox
//
//  Created by Kubilay Erdogan on 13/06/15.
//  Copyright (c) 2015 Kubilay Erdogan
//

import Foundation
import UIKit

extension String {
    
    func floatValue() -> Float {
        return (self as NSString!).floatValue
    }
    
    func numberValue() -> NSNumber {
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return numberFormatter.numberFromString(self) as NSNumber!
    }
    
    func dateValue(format: String?) -> NSDate {
        var dateFormatter = NSDateFormatter()
        if let newFormat = format {
            dateFormatter.dateFormat = newFormat
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }
        if let retDate: NSDate = dateFormatter.dateFromString(self) {
            return retDate
        } else {
            return NSDate()
        }
    }
    
    func boolValue() -> Bool {
        switch self {
        case "0","false","FALSE","no","NO","hayir","HAYIR":
            return false
        case "1","true","TRUE","yes","YES","evet","EVET":
            return true
        default:
            return false
        }
    }
    
}

extension NSDate {
    
    func stringValue(format: String?) -> String {
        var dateFormatter = NSDateFormatter()
        if let newFormat = format {
            dateFormatter.dateFormat = newFormat
        } else {
            dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        }
        return dateFormatter.stringFromDate(self)
    }
    
}

extension NSDictionary {
    
    func isNullOrEmpty() -> Bool {
        return self.isEqual(NSDictionary())
    }
    
}

extension UILabel {
    
    func resize(size: CGFloat) {
        self.font = self.font.fontWithSize(size)
    }
    
}

extension UIColor {
    
    convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (count(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
}

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { self.addSubview(view) }
    }
    
    func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            _superview = superview.superview
        }
        self.removeConstraints(self.constraints)
    }
}

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
