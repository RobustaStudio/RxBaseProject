//
//  ViewModel.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RxBaseProject

protocol ExampleViewModelType: BaseViewModelType {

}


class ExampleViewModel: BaseViewModel , ExampleViewModelType{
    
    
    override init() {
        super.init()
        
        
        self.viewWillAppear.subscribe(onNext: { (_) in
            
            _ = APIManager.shared.getNews().subscribe(onNext: { (news) in
                print(news)
            })
            
        }).addDisposableTo(self.dBag)
        
    }
}
