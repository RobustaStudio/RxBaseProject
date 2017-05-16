//
//  BaseViewModel.swift
//
//  Created by Ahmed Mohamed Fareed on 1/31/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

/// BaseProtocolType contains main input & outputs for whoever implements it
public protocol BaseViewModelType : class {
    
    // Input
    var viewDidLoad: PublishSubject<Void> { get }
    var viewDidDeallocate: PublishSubject<Void> { get }
    var viewWillAppear: PublishSubject<Bool> { get }
}

open class BaseViewModel: BaseViewModelType {
    
    // input
    open let viewDidLoad = PublishSubject<Void>()
    open let viewDidDeallocate = PublishSubject<Void>()
    open let viewWillAppear = PublishSubject<Bool>()
    
    // Variables
    open let dBag:DisposeBag = DisposeBag()
    
    /// Returns an instant from MiniCashViewModel
    public init() {
    }
    
    public func placeholderTextBaseOn<T:Any>(tableViewPlaceHolderText:inout Driver<String>,triger:Observable<Void>? = nil, data:Observable<T>, loadingText:String? = nil, emptyText:String? = nil) {
        let tableIsLoading = Variable<String>("")
        tableViewPlaceHolderText = tableIsLoading.asDriver()
        
        viewWillAppear.asObservable().subscribe(onNext: {(_) in
            tableIsLoading.value = NSLocalizedString("Loading", comment: "")
        }).addDisposableTo(dBag)
        
        if let _triger = triger  {
            _triger.subscribe(onNext: {(_) in
                if let text = loadingText {
                    tableIsLoading.value = NSLocalizedString(text, comment: "")
                }else {
                    tableIsLoading.value = NSLocalizedString("Loading", comment: "")
                }
            }).addDisposableTo(dBag)
        }
        
        data.asObservable().subscribe(onNext: {(data) in
            if let text = emptyText {
                tableIsLoading.value = NSLocalizedString(text, comment: "")
            }else {
                tableIsLoading.value = NSLocalizedString("Empty", comment: "")
            }
        }).addDisposableTo(dBag)
        
    }
}


