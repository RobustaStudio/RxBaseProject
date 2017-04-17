//
//  BaseViewModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 1/31/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//


import Foundation
import RxSwift
import RxCocoa

/// BaseProtocolType contains main input & outputs for whoever implements it
protocol BaseViewModelType : class {
    
    // Input
    var viewDidLoad: PublishSubject<Void> { get }
    var viewDidDeallocate: PublishSubject<Void> { get }
    var viewWillAppear: PublishSubject<Bool> { get }

    // Output
    var tableViewPlaceholderText:Driver<String> {get}
}

class BaseViewModel: BaseViewModelType {

    // input
    let viewDidLoad = PublishSubject<Void>()
    let viewDidDeallocate = PublishSubject<Void>()
    let viewWillAppear = PublishSubject<Bool>()
    
    // output
    var tableIsLoading = Variable<String>("")
    var tableViewPlaceholderText = Driver<String>.empty()
    
    // Variables
    let dBag:DisposeBag = DisposeBag()
    
    /// Returns an instant from MiniCashViewModel
    init() {
        tableViewPlaceholderText = tableIsLoading.asObservable().asDriver(onErrorJustReturn: "")
    }
    
    func placeholderTextBaseOn<T:Any>(triger:PublishSubject<Void>? = nil, data:Observable<T>, loadingText:String? = nil, emptyText:String? = nil) {
        viewWillAppear.asObservable().subscribe(onNext: {[weak self] (_) in
            self?.tableIsLoading.value = NSLocalizedString("Loading", comment: "")
        }).addDisposableTo(dBag)
        
        if let _triger = triger  {
            _triger.asObservable().subscribe(onNext: {[weak self] (_) in
                if let text = loadingText {
                    self?.tableIsLoading.value = NSLocalizedString(text, comment: "")
                }else {
                    self?.tableIsLoading.value = NSLocalizedString("Loading", comment: "")
                }
            }).addDisposableTo(dBag)
        }
        
        data.asObservable().subscribe(onNext: {[weak self] (data) in
            if let text = emptyText {
                self?.tableIsLoading.value = NSLocalizedString(text, comment: "")
            }else {
                self?.tableIsLoading.value = NSLocalizedString("Empty", comment: "")
            }
        }).addDisposableTo(dBag)
    }
}


