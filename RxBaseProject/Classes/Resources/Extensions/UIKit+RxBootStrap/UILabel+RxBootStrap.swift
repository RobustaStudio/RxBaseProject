//
//  UILabel+Rx.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/21/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
    
    /// Bindable sink for `Color` property.
    public var textColor: UIBindingObserver<Base, UIColor?> {
        return UIBindingObserver(UIElement: self.base) { label, color in
            label.textColor = color
        }
    }
}
