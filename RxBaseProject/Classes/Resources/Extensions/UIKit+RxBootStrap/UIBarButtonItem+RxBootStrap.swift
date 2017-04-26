//
//  UIBarButtonItem+Rx.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 3/4/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIBarButtonItem {
    
    /// Bindable sink for `Color` property.
    public var image: UIBindingObserver<Base, UIImage?> {
        return UIBindingObserver(UIElement: self.base) { button, image in
            button.image = image
        }
    }
}

