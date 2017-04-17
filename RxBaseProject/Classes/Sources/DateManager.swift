//
//  Formatter.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/26/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit

public final class DateManager: NSObject {
    fileprivate override init() { super.init() }
    
    
    /// Formatter With formate yyyy-MM-dd HH:mm:ss
    static var SharedDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    /// Formatter With formate yyyy-MM-DD
    static var SharedFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    /// Formatter With formate MMMM, DD, yyyy
    static var SharedSMSFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM, dd, yyyy"
        return dateFormatter
    }()
    
    /// Formatter With formate yyyy-MM-DD
    static var SharedDOBFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    /// Formatter With formate DD MMMM yyyy
    static var SharedCampaignRecipientsFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
//        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter
    }()
    
    /// Formatter With formate DD/MM/yyyy
    static var SharedDefaultFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    /// Formatter With formate MM/DD/yyyy
    static var SharedDefaultFormatter2: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    
    static var sharedNumberDecimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    static func FormatInt(_ number:Int) -> String {
        let _number = NSNumber(value: number)
        return FormatNumber(_number)
    }
    
    static func FormatLong(_ number:CLongLong) -> String {
        let _number = NSNumber(value: number)
        return FormatNumber(_number)
    }
    
    static func FormatDouble(_ number:Double) -> String {
        let _number = NSNumber(value: number)
        return FormatNumber(_number)
    }
    
    static func FormatNumber(_ number:NSNumber?) -> String {
        guard let num = number else {return ""}
        guard let result = sharedNumberDecimalFormatter.string(from: num) else {return ""}
        return result
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
