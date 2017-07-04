//
//  Config.swift
//
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

public enum AppConfigurations {
    // __urls keys
    case staggingURLValue
    case productionURLValue
    case imageURLSuffixValue
    case requestURLSuffixValue
    
    // __security Keys
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


public protocol ConfigurationsProtocol {
    
    static var shared:ConfigurationsProtocol {get}
    
    var security:ConfigSecurity? {get}
    var urls:ConfigURLs? {get}
    
    var usingRefreshToken:Bool {get}
    var isProduction:Bool! {get}
    var usingStubbed:Bool! {get}
    var url:String {get}
    
    func configure(con:[AppConfigurations:Any])
}

public class Config:ConfigurationsProtocol {
    
    // public Variables
    public static var shared:ConfigurationsProtocol = Config()
    public var security: ConfigSecurity?
    public var urls:ConfigURLs?
    
    public var usingStubbed:Bool!
    public var isProduction:Bool!
    
    // Pod Private Variables
    var _security:__security? {
        didSet {
            security = _security
        }
    }
    
    var _urls:__urls? {
        didSet {
            urls = _urls
        }
    }
    
    var refreshTokenStatus:Bool = false
    
    public func configure(con:[AppConfigurations:Any]) {
        
        self.security = __security(configurations: con)
        self.urls = __urls(configurations: con)
        
        self.isProduction = con[AppConfigurations.isProduction] as? Bool ?? false
        self.usingStubbed = con[AppConfigurations.isUsingStubbedAPIs] as? Bool ?? false
        
        if let allowRefeshToken = con[AppConfigurations.usingRefreshToken] as? Bool {
            self.refreshTokenStatus = allowRefeshToken
        }
    }

    public var usingRefreshToken:Bool {
        return self.refreshTokenStatus
    }
    
    public var url:String {
        guard let `_urls` = self.urls else { return "" }
        if isProduction {
            return _urls.productionURL
        }else {
            return _urls.staggingURL
        }
    }
}
