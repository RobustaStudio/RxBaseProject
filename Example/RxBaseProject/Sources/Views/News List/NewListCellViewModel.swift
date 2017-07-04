//
//  NewListCellModel.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation


protocol NewListCellViewModelType {
    var title:String {get}
    var url:URL? {get}
}

class NewListCellViewModel: NewListCellViewModelType {
    
    var title:String
    var url:URL?
    
    init(model:NewsItemModel) {
        self.title = model.newsItemName
        self.url = URL(string: model.newsItemImageURLString)
    }
}
