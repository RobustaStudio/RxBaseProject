//
//  UITextField+Rx.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/26/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    
    /// Bindable sink for `String` property.
    public var placeholderText: UIBindingObserver<Base, String?> {
        return UIBindingObserver(UIElement: self.base) { textField, text in
            textField.placeholder = text
        }
    }
}
