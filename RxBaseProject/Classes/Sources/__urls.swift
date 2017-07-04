//
//  __urls.swift
//  Pods
//
//  Created by Ahmed Magdi on 7/4/17.
//
//

import Foundation


public protocol ConfigURLs {
    var staggingURL:String {get}
    var productionURL:String {get}
    var imageURLSuffix:String {get}
    var requestURLSuffix:String {get}
}

class __urls:ConfigURLs {
    var staggingURL:String = ""
    var productionURL:String = ""
    var imageURLSuffix:String = ""
    var requestURLSuffix:String = ""
    
    convenience init(configurations con:[AppConfigurations:Any]) {
        self.init(staggingURL: con[AppConfigurations.staggingURLValue] as? String,
               productionURL: con[AppConfigurations.productionURLValue] as? String,
               imageURLSuffix: con[AppConfigurations.imageURLSuffixValue] as? String,
               requestURLSuffix: con[AppConfigurations.requestURLSuffixValue] as? String)
        
        if (self.productionURL == "" && con[AppConfigurations.productionURLValue] != nil) ||
            (self.staggingURL == "" && con[AppConfigurations.staggingURLValue] != nil) {
            fatalError("If either productionURL or Stagging URL is set to be confiured, then their values can not be empty")
        }
    }
    
    init(staggingURL:String?, productionURL:String?, imageURLSuffix:String?, requestURLSuffix:String?) {
        self.staggingURL = staggingURL ?? ""
        self.productionURL = productionURL ?? ""
        self.imageURLSuffix = imageURLSuffix ?? ""
        self.requestURLSuffix = requestURLSuffix ?? ""
    }
}
