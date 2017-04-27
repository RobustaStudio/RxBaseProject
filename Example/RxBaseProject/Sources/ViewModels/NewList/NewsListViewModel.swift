//
//  ViewModel.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RxBaseProject
import RxDataSources
import RxSwift
import RxCocoa

protocol NewsListViewModelType: BaseViewModelType {
    // Input
    var reloadTrigger: PublishSubject<Void> { get }
    
    // Output
    var sections:Driver<[NewListSection]> { get }
    var tableViewPlaceholderText:Driver<String> {get}
}

class NewsListViewModel: BaseViewModel , NewsListViewModelType {
    
    // Input
    var reloadTrigger = PublishSubject<Void>()
    
    // Output
    var sections = Driver<[NewListSection]>.empty()
    var tableViewPlaceholderText = Driver<String>.empty()

    override init() {
        super.init()
        
        let reloadedData = self.reloadTrigger
            .asObservable()
            .debounce(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest { (_) -> Observable<NewsModel> in
                return APIManager.shared.getNews()
            }.do(onNext: { (s) in
              print(s)
            })

        let onViewData = self.viewWillAppear
            .asObservable()
            .withLatestFrom(APIManager.shared.getNews())
            .do(onNext: { (s) in
                print(s)
            })
        
        let loadedData = Observable.of(reloadedData, onViewData)
            .merge()
            .do(onNext: { (mew) in
                print("asd")
                print(mew)
            })
        
        self.sections = loadedData.map({ (model) -> [NewListSection] in
            var list:[NewListCellViewModel] = []
            if model.lists != nil {
                list = model.lists!.map{ NewListCellViewModel(model: $0) }
            }
            return [NewListSection(model: Void(), items: list)]
        }).asDriver(onErrorJustReturn: [])
        
        self.placeholderTextBaseOn(tableViewPlaceHolderText: &tableViewPlaceholderText, data: loadedData)
    }
}
