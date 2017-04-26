//
//  UIViewController+Rx.swift
//  RxTodo
//
//  Created by Suyeol Jeon on 12/01/2017.
//  Copyright © 2017 Suyeol Jeon. All rights reserved.
//

import UIKit

import RxSwift

extension Reactive where Base: UIViewController {

  var viewDidLoad: Observable<Void> {
    return self.sentMessage(#selector(Base.viewDidLoad)).map { _ in Void() }
  }

  var viewWillAppear: Observable<Bool> {
    return self.sentMessage(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
  }
  var viewDidAppear: Observable<Bool> {
    return self.sentMessage(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
  }

  var viewWillDisappear: Observable<Bool> {
    return self.sentMessage(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
  }
  var viewDidDisappear: Observable<Bool> {
    return self.sentMessage(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
  }

  var viewWillLayoutSubviews: Observable<Void> {
    return self.sentMessage(#selector(Base.viewWillLayoutSubviews)).map { _ in Void() }
  }
  var viewDidLayoutSubviews: Observable<Void> {
    return self.sentMessage(#selector(Base.viewDidLayoutSubviews)).map { _ in Void() }
  }

}

// MARK: - Reactive extensions

extension Reactive where Base: UIScrollView {
    
    // MARK: - UIScrollView reactive extension
    
    public var reachedBottom: Observable<Void> {
        let scrollView = self.base as UIScrollView
        return self.contentOffset.flatMap{ [weak scrollView] (contentOffset) -> Observable<Void> in
            guard let scrollView = scrollView else { return Observable.empty() }
            let visibleHeight = scrollView.frame.height - self.base.contentInset.top - scrollView.contentInset.bottom
            let y = contentOffset.y + scrollView.contentInset.top
            let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
            return (y > threshold) ? Observable.just(()) : Observable.empty()
        }
    }
    
    public var startedDragging: Observable<Void> {
        let scrollView = self.base as UIScrollView
        return scrollView.panGestureRecognizer.rx
            .event
            .filter({ $0.state == .began })
            .map({ _ in () })
    }
}
