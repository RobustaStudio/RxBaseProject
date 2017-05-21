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
    
    public func placeholderTextBaseOn<T:Any>(tableViewPlaceHolderText:inout Driver<String>,
                                      triger:Observable<Void>,
                                      data:Driver<T>, loadingText:String, emptyText:String)
    {
        tableViewPlaceHolderText = Observable.of(triger.withLatestFrom(Observable.just(loadingText)),
                                                 data.asObservable().withLatestFrom(Observable.just(emptyText)))
            .merge()
            .asDriver(onErrorJustReturn: "")
    }
}


