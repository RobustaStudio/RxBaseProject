//
//  ObservableConvertibleType+Void.swift
//  RxTodo
//
//  Created by Suyeol Jeon on 7/2/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableConvertibleType where E == Void {

  func asDriver() -> Driver<E> {
    return self.asDriver(onErrorJustReturn: Void())
  }
}
