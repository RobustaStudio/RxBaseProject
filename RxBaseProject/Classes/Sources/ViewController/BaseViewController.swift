//
//  BaseViewController.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 1/31/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import RxSwift
import Then

open class BaseViewController: UIViewController {

    open var disposeBag = DisposeBag()
    
    //MARK:- Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureRx()
        
        self.view.endEditing(true)
        self.rx.viewWillDisappear.asDriver(onErrorJustReturn: false).drive(onNext: { (_) in
            AppDelegate.dismissLoadingProgress()
        }).addDisposableTo(self.disposeBag)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.endEditing(true)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK:- View Configuration Managment functions

    /// To be overriden in subclasses for configuring ViewController Views
    open func configureView() {}
    
    /// To be overriden in subclasses for configuring ViewController RxData
    open func configureRx() {}
    
    //MARK:- Navigation
    
    /// Helper function helps in presenting passed viewcontroller over current viewController as modal representation
    ///
    /// - Parameters:
    ///   - view: desired viewController
    ///   - animated: animated presentation or not
    ///   - completion: callBack block after done presentation
    open func presentOverCurrentView(_ view:UIViewController, _ animated:Bool = true, completion:(() -> Void)? = nil) {
        view.modalPresentationStyle = .overCurrentContext
        self.present(view, animated: animated, completion: completion)
    }
}
