//
//  AppSetup.swift
//  
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

public enum AppConfigurations:Int {
    // _URLs keys
    case staggingURLValue       = 0
    case productionURLValue
    case imageURLSuffixValue
    case requestURLSuffixValue
    
    // _Security Keys
    case clientIdKey
    case clientIdValue
    case clientSecretKey
    case clientSecretValue
    case appTokenKey
    case appTokenValue
    case isUsingAppToken
    
    case isProduction
    case isUsingStubbedAPIs
    case usingRefreshToken
}

extension AppConfigurations: Equatable {}

public func == (lhs: AppConfigurations, rhs: AppConfigurations) -> Bool {
    if lhs.hashValue == rhs.hashValue {
        return true
    }
    return false
}

public class _URLs {
    var url:String = ""
    var staggingURL:String = ""
    var productionURL:String = ""
    var imageURLSuffix:String = ""
    var requestURLSuffix:String = ""
    
    public init(staggingURL:String?, productionURL:String?, imageURLSuffix:String?, requestURLSuffix:String?) {
        self.staggingURL = staggingURL ?? ""
        self.productionURL = productionURL ?? ""
        self.imageURLSuffix = imageURLSuffix ?? ""
        self.requestURLSuffix = requestURLSuffix ?? ""
        
        if Config.shared.usingProduction {
            url = self.productionURL
        }else{
            url = self.staggingURL
        }
    }
}

class _Security {
    var clientIdKey:String       = "client_id"
    var clientSecretKey:String   = "client_secret"
    var appTokenKey:String       = "app_token"
    
    var clientIdValue:String     = ""
    var clientSecretValue:String = ""
    var appTokenValue:String     = ""
    
    var usingAppToken:Bool = false
    
    init(clientId:String?, clientSecret:String?, clientIdKey:String?=nil, clientSecretKey:String?=nil) {
        self.clientIdValue = clientId ?? ""
        self.clientSecretValue = clientSecret ?? ""
        
        self.usingAppToken = false
        
        if let idKey = clientIdKey {
            self.clientIdKey = idKey
        }
        
        if let secretKey = clientSecretKey {
            self.clientSecretKey = secretKey
        }
    }
    
    init(appToken:String?, tokenKey:String?=nil) {
        self.appTokenValue = appToken ?? ""
        self.usingAppToken = true
        if let tKey = tokenKey {
            self.appTokenKey = tKey
        }
    }
}

public class Config {
    
    public static var shared:Config = Config()
    
    var security:_Security?
    var urls:_URLs?
    var isProduction:Bool = false {
        didSet {
            if urls != nil {
                if isProduction {
                    urls!.url = urls!.productionURL
                }else {
                    urls!.url = urls!.staggingURL
                }
            }
        }
    }
    var refreshTokenStatus:Bool = false
    
    public func configure(con:[AppConfigurations:Any]) {
        
        self.security = _Security(clientId: con[AppConfigurations.clientIdValue] as? String,
                                  clientSecret: con[AppConfigurations.clientSecretValue] as? String,
                                  clientIdKey: con[AppConfigurations.clientIdKey] as? String,
                                  clientSecretKey: con[AppConfigurations.clientSecretKey] as? String)
        
        
        self.urls = _URLs(staggingURL: con[AppConfigurations.staggingURLValue] as? String,
                          productionURL: con[AppConfigurations.productionURLValue] as? String,
                          imageURLSuffix: con[AppConfigurations.imageURLSuffixValue] as? String,
                          requestURLSuffix: con[AppConfigurations.requestURLSuffixValue] as? String)
        
        if let productStatus = con[AppConfigurations.isProduction] as? Bool {
            self.isProduction = productStatus
        }else {
            self.isProduction = false
        }
        
        if let allowRefeshToken = con[AppConfigurations.usingRefreshToken] as? Bool {
            self.refreshTokenStatus = allowRefeshToken
        }else {
            self.refreshTokenStatus = false
        }
    }
    
    public var usingProduction:Bool {
        return self.isProduction
    }
    
    public var usingStubbed:Bool {
        return false
    }
    
    public var usingRefreshToken:Bool {
        return self.refreshTokenStatus
    }
    
    public var clientId:String {
        guard let seucrity = self.security else { return "" }
        return seucrity.usingAppToken ? "" : seucrity.clientIdValue
    }
    
    public var clientSecret:String {
        guard let seucrity = self.security else { return "" }
        return seucrity.usingAppToken ? "" : seucrity.clientSecretValue
    }
    
    public var appToken:String {
        guard let seucrity = self.security else { return "" }
        return seucrity.usingAppToken ? seucrity.appTokenValue : ""
    }
    
    public var url:String {
        guard let urls = self.urls else { return "" }
        return urls.url
    }
    
    public var stagingURL:String {
        guard let urls = self.urls else { return "" }
        return urls.staggingURL
    }
    
    public var productionURL:String {
        guard let urls = self.urls else { return "" }
        return urls.productionURL
    }
    
    public var imagesURL:String {
        guard let urls = self.urls else { return "" }
        return urls.imageURLSuffix
    }
    
    public var requestSuffixURL:String {
        guard let urls = self.urls else { return "" }
        return urls.requestURLSuffix
    }
}
