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
        let dateFormatter = formatter(with: "yyyy-MM-dd HH:mm:ss")
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    /// Formatter With formate yyyy-MM-DD
    public static var sharedFormatter: DateFormatter = {
        return formatter(with: "yyyy-MM-dd")
    }()
    
    /// Formatter With format MMMM, DD, yyyy
    public static var sharedSMSFormatter: DateFormatter = {
        return formatter(with: "MMMM, dd, yyyy")
    }()
    
    /// Formatter With format yyyy-MM-DD
    public static var sharedDOBFormatter: DateFormatter = {
        return formatter(with: "yyyy-MM-dd")
    }()
    
    /// Formatter With format DD MMMM yyyy
    public static var sharedCampaignRecipientsFormatter: DateFormatter = {
        return formatter(with: "dd MMMM yyyy")
    }()
    
    /// Formatter With format DD/MM/yyyy
    public static var sharedDefaultFormatter: DateFormatter = {
        return formatter(with: "dd/MM/yyyy")
    }()
    
    /// Formatter With format MM/DD/yyyy
    public static var sharedDefaultFormatter2: DateFormatter = {
        return formatter(with: "MM/dd/yyyy")
    }()
    
    /// Formatter With format yyyy-MM-dd HH:mm:ss
    public static var sharedDateFormatter_3: DateFormatter = {
        return formatter(with: "MMM dd, yyyy")
    }()
    
    public static var sharedNumberDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        if let localLang = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
            formatter.locale = Locale(identifier: localLang.first!)
        }
        formatter.numberStyle = .decimal
        return formatter
    }()
}

fileprivate func formatter(with format:String) -> DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    if let localLang = UserDefaults.standard.value(forKey: "AppleLanguages") as? [String] {
        dateFormatter.locale = Locale(identifier: localLang.first!)
    }
    return dateFormatter
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
