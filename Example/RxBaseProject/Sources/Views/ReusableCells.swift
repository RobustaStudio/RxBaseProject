//
//  ReusableCells.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/18/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import ReusableKit

struct Reusable {
    
    static let `default` = ReusableCell<UITableViewCell>()
    static let newsCell = ReusableCell<NewsListTableViewCell>(nibName: "NewsListTableViewCell")
    
}
