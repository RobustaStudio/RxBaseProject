//
//  UITableView+Placeholder.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

extension UITableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    private static let association = ObjectAssociation<Any>()
    
    public var placeholderText: String? {
        get { return UITableView.association[self] as? String }
        set {
            UITableView.association[self] = newValue
            self.reloadEmptyDataSet()
        }
    }

    public var placeholderColor: UIColor? {
        get { return UITableView.association[self] as? UIColor }
        set {
            UITableView.association[self] = newValue
            self.reloadEmptyDataSet()
        }
    }
    
    public var placeholderFontSize: CGFloat? {
        get { return UITableView.association[self] as? CGFloat }
        set {
            UITableView.association[self] = newValue
            self.reloadEmptyDataSet()
        }
    }
    
    public var placeholderFontFamily: String? {
        get { return UITableView.association[self] as? String }
        set {
            UITableView.association[self] = newValue
            self.reloadEmptyDataSet()
        }
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -15
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        guard let placeholderValue = placeholderText else {
            return NSMutableAttributedString(string: "Empty".localized)
        }
        
        let text = placeholderText ?? "Empty"
        let color = placeholderColor ?? UIColor.darkGray
        let fontSize = placeholderFontSize ?? 25
        
        let textRange = NSMakeRange(0, text.characters.count)
        
        let attributedString = NSMutableAttributedString(string: placeholderValue.localized)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: textRange)
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: fontSize), range: textRange)
        
        return attributedString
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func configureDelegate() {
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
    }
}
