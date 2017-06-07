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
    
    private static let association_placeholder = ObjectAssociation<Any>()
    private static let association_placeholderFontColor = ObjectAssociation<UIColor>()
    private static let association_placeholderFont = ObjectAssociation<UIFont>()
    
    public var placeholderText: String? {
        get { return UITableView.association_placeholder[self] as? String }
        set {
            UITableView.association_placeholder[self] = newValue
            self.reloadEmptyDataSet()
        }
    }

    public var placeholderColor: UIColor? {
        get { return UITableView.association_placeholderFontColor[self] }
        set {
            UITableView.association_placeholderFontColor[self] = newValue
            self.reloadEmptyDataSet()
        }
    }
    
    public var placeholderFont: UIFont? {
        get { return UITableView.association_placeholderFont[self] }
        set {
            UITableView.association_placeholderFont[self] = newValue
            self.reloadEmptyDataSet()
        }
    }
    
    public func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return -15
    }
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        guard let placeholderValue = placeholderText else {
            return NSMutableAttributedString(string: "".localized)
        }
        
        let text = placeholderText ?? ""
        let color = placeholderColor ?? UIColor.darkGray
        let font = placeholderFont ?? UIFont.systemFont(ofSize: 25)
        
        let textRange = NSMakeRange(0, text.characters.count)
        
        let attributedString = NSMutableAttributedString(string: placeholderValue.localized)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: textRange)
        attributedString.addAttribute(NSFontAttributeName, value: font, range: textRange)
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
