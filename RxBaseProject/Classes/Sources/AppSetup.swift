//
//  AppSetup.swift
//  
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

public class AppURLs {
    var url:String = ""
    var staggingURL:String = ""
    var productionURL:String = ""
    var imageURLSuffix:String = ""
    var requestURLSuffix:String = ""
    
    public init(staggingURL:String, productionURL:String, imageURLSuffix:String, requestURLSuffix:String) {
        self.staggingURL = staggingURL
        self.productionURL = productionURL
        self.imageURLSuffix = imageURLSuffix
        self.requestURLSuffix = requestURLSuffix
    }
}

public class AppSecurity {
    var clientIdKey:String       = "client_id"
    var clientSecretKey:String   = "client_secret"
    var appTokenKey:String       = "app_token"
    
    var clientIdValue:String     = ""
    var clientSecretValue:String = ""
    var appTokenValue:String     = ""
    
    var usingAppToken:Bool = false
    
    public init(clientId:String, clientSecret:String, clientIdKey:String?=nil, clientSecretKey:String?=nil) {
        self.clientIdValue = clientId
        self.clientSecretValue = clientSecret
        
        self.usingAppToken = false
        
        if let idKey = clientIdKey {
            self.clientIdKey = idKey
        }
        
        if let secretKey = clientSecretKey {
            self.clientSecretKey = secretKey
        }
    }
    
    public init(appToken:String, tokenKey:String?=nil) {
        self.appTokenValue = appToken
        self.usingAppToken = true
        if let tKey = tokenKey {
            self.appTokenKey = tKey
        }
    }
}

public class AppConfig {
    fileprivate static let `default` = AppConfig()
    public var security:AppSecurity?
    public var urls:AppURLs? {
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
    
    public var isProduction:Bool = false {
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
    public var useStubbedApis:Bool = false
    public var allowRefreshToken:Bool = true
    
    public init() {
        security = nil
        urls = nil
    }
}

public class AppSetup {
    
    public static var shared:AppSetup = AppSetup()
    
    public func setSecurity(security:AppSecurity) {
        config.security = security
    }
    
    public func setURLs(urls:AppURLs) {
        config.urls = urls
    }
    
    private var config:AppConfig {
       return AppConfig.default
    }
    
    public var usingProduction:Bool {
        return config.isProduction
    }
    
    public var usingStubbed:Bool {
        return config.useStubbedApis
    }
    
    public var allowRefreshToken:Bool {
        return config.allowRefreshToken
    }
    
    public var clientId:String {
        guard let seucrity = config.security else { return "" }
        return seucrity.usingAppToken ? "" : seucrity.clientIdValue
    }
    
    public var clientSecret:String {
        guard let seucrity = config.security else { return "" }
        return seucrity.usingAppToken ? "" : seucrity.clientSecretValue
    }
    
    public var appToken:String {
        guard let seucrity = config.security else { return "" }
        return seucrity.usingAppToken ? seucrity.appTokenValue : ""
    }
    
    public var url:String {
        guard let urls = config.urls else { return "" }
        return urls.url
    }
    
    public var stagingURL:String {
        guard let urls = config.urls else { return "" }
        return urls.staggingURL
    }
    
    public var productionURL:String {
        guard let urls = config.urls else { return "" }
        return urls.productionURL
    }
    
    public var imagesURL:String {
        guard let urls = config.urls else { return "" }
        return urls.imageURLSuffix
    }
    
    public var requestSuffixURL:String {
        guard let urls = config.urls else { return "" }
        return urls.requestURLSuffix
    }
}
