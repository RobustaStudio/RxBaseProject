//
//  Formatter.swift
//
//
//  Created by Ahmed Mohamed Fareed on 2/26/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit

public final class DataManager: NSObject {
    fileprivate override init() { super.init() }
    
    /// Formatter With formate yyyy-MM-dd HH:mm:ss
    public static var sharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    /// Formatter With formate yyyy-MM-DD
    public static var sharedFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    /// Formatter With formate MMMM, DD, yyyy
    public static var sharedSMSFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, dd, yyyy"
        return dateFormatter
    }()
    
    /// Formatter With formate yyyy-MM-DD
    public static var sharedDOBFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    /// Formatter With formate DD MMMM yyyy
    public static var sharedCampaignRecipientsFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    /// Formatter With formate DD/MM/yyyy
    public static var sharedDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    /// Formatter With formate MM/DD/yyyy
    public static var sharedDefaultFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    
    public static var sharedNumberDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}

fileprivate func FormatNumber(_ number:NSNumber?) -> String {
    guard let num = number else {return ""}
    guard let result = DataManager.sharedNumberDecimalFormatter.string(from: num) else {return ""}
    return result
}

//extension NSNumber {
//    static func Format() -> String {
//        if self == nil {return ""}
//        guard let result = DataManager.sharedNumberDecimalFormatter.string(from: self) else {return ""}
//        return result
//    }
//}

extension Int {
    public func format() -> String {
        let _number = NSNumber(value: self)
        return FormatNumber(_number)
    }
}

extension CLongLong {
    public func format() -> String {
        let _number = NSNumber(value: self)
        return FormatNumber(_number)
    }
}

extension Double {
    public func format() -> String {
        let _number = NSNumber(value: self)
        return FormatNumber(_number)
    }
}

extension NumberFormatter {
    func forceEnglishString(from number:NSNumber?) -> String? {
        guard let _number = number else {return nil}
        let formatter = self
        formatter.locale =  Locale(identifier: "EN")
        return formatter.string(from: _number)
    }
}

extension DateFormatter {
    func forceEnglishString(from date:Date?) -> String? {
        guard let _date = date else {return nil}
        let formatter = self
        formatter.locale =  Locale(identifier: "EN")
        return formatter.string(from: _date)
    }
}
