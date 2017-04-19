//
//  UITableView+Placeholder.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import RxSwift

//class PlaceholderTableView: UITableView, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
//    
//    var placeholderText:String = NSLocalizedString("", comment: "") {
//        didSet {
//            self.reloadEmptyDataSet()
//        }
//    }
//
//    let disposeB = DisposeBag()
//    
//    override init(frame: CGRect, style: UITableViewStyle) {
//        super.init(frame: frame, style: style)
//        configureRx()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        configureRx()
//    }
//    
//    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        let attributedString = NSMutableAttributedString(string: placeholderText)
//        return attributedString
//    }
//    
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//    
//    private func configureRx() {
//        self.emptyDataSetSource = self
//        self.emptyDataSetDelegate = self
//        
//        
//    }
//}



extension UITableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    var placeholderText:String {
        didSet {
            self.reloadEmptyDataSet()
        }
    }
    
    
    
    public func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString(string: "This is a test")
        return attributedString
    }
    
    public func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func configureRx() {
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self

    }
}
