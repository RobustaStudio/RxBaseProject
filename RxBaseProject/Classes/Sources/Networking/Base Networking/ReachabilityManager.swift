//
//  ReachabilityManager.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/22/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import RxSwift
import ReachabilitySwift

//#if SwiftMessages
import SwiftMessages
//#endif

private let reachabilityManager = ReachabilityManager()


/// An observable that completes when the app gets online (possibly completes immediately).
///
/// - Returns: Observable of boolean
func connectedToInternetOrStubbing() -> Observable<Bool> {
//    let stubbing = Observable.just(AppSetup.useStubbed)
    guard let online = reachabilityManager?.reach else {
        return Observable.just(false)
    }
    return online //[online, stubbing].combineLatestOr()
}


class ReachabilityManager {
    
    private let reachability: Reachability
    
    let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
    var reach: Observable<Bool> {
        return _reach.asObservable()
    }
        
    
    var view:MessageView!
    
    init?() {
        guard let r = Reachability() else {
            return nil
        }
        self.reachability = r
        
        do {
            try self.reachability.startNotifier()
        } catch {
            return nil
        }
        
        self._reach.onNext(self.reachability.isReachable)
        
            
        view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.configureContent(body: "Unable to reach internet, retrying".localized)
        
        var config = SwiftMessages.defaultConfig
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        config.duration = .forever
        config.dimMode = .none
        config.interactiveHide = false
        config.preferredStatusBarStyle = .lightContent
            
        self.reachability.whenReachable = { _ in
            print("reachable")
            SwiftMessages.hide()
            DispatchQueue.main.async { self._reach.onNext(true) }
        }
        
        self.reachability.whenUnreachable = {[unowned self] _ in
            print("Not reachable")
            DispatchQueue.main.async {[unowned self] _ in
                SwiftMessages.show(config: config, view: self.view)
            }
            DispatchQueue.main.async { self._reach.onNext(false) }
        }
    }
    
    
    
    deinit {
        reachability.stopNotifier()
    }
}
