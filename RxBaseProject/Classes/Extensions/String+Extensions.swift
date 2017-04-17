//
//  String+Extensions.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/27/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

extension String {
    /// extracts digit only from current string
    ///
    /// - Returns: digit only string
    func getDigitsOnly() -> String {
        let regex = try! NSRegularExpression(pattern: "[0-9]", options: [])
        let matches = regex.matches(in: self, options: [NSRegularExpression.MatchingOptions.withTransparentBounds], range: NSRange(location: 0, length: self.characters.count)).map { (self as NSString).substring(with: $0.range)}
        let result  = (matches as NSArray).componentsJoined(by: "")
        return result
    }
    
//    /// Adding underline to current string
//    ///
//    /// - Returns: underlined attributedString
//    func underlineString() -> NSAttributedString {
//        let textRange = NSMakeRange(0, self.characters.count)
//        let attributedText = NSMutableAttributedString(string: self)
//        attributedText.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
//        // Add other attributes if needed
//        return attributedText
//    }
}
