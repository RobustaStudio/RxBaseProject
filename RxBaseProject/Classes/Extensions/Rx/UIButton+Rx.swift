//
//  UIButton+Rx.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/1/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIButton {
    
    /// Bindable sink for `Color` property.
    public var isLoading: UIBindingObserver<Base, Bool?> {
        return UIBindingObserver(UIElement: self.base) { button, loading in
            button.loadingIndicator(loading ?? false)
        }
    }
}
