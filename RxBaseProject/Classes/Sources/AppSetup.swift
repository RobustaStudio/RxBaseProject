//
//  AppSetup.swift
//  
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

struct BaseURL {
    var url:String
    var staggingURL:String
    var productionURL:String
    var imageURLSuffix:String
    var requestURLSuffix:String
}

struct AppSecurity {
    var clientIdKey:String       = "client_id"
    var clientSecretKey:String   = "client_secret"
    var appTokenKey:String       = "app_token"
    
    var clientIdValue:String     = ""
    var clientSecretValue:String = ""
    var appTokenValue:String     = ""
    
    var usingAppToken:Bool = false
    
    init(clientId:String, clientSecret:String, clientIdKey:String?=nil, clientSecretKey:String?=nil) {
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
    
    init(appToken:String, tokenKey:String?=nil) {
        self.appTokenValue = appToken
        self.usingAppToken = true
        if let tKey = tokenKey {
            self.appTokenKey = tKey
        }
    }
}

public struct AppConfig {
    var security:AppSecurity
    var urls:BaseURL
    
    var isProduction:Bool = false
    var useStubbedApis:Bool = false
    var allowRefreshToken:Bool = true
}

public class AppSetup {
    
    public static var shared:AppSetup!
    
    private var config:AppConfig!
    
    init(config:AppConfig) {
        self.config = config
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
        return config.security.usingAppToken ? "" : config.security.clientIdValue
    }
    
    public var clientSecret:String {
        return config.security.usingAppToken ? "" : config.security.clientSecretValue
    }
    
    public var appToken:String {
        return config.security.usingAppToken ? config.security.appTokenValue : ""
    }
    
    public var url:String {
        return config.urls.url
    }
    
    public var stagingURL:String {
        return config.urls.staggingURL
    }
    
    public var productionURL:String {
        return config.urls.productionURL
    }
    
    public var imagesURL:String {
        return config.urls.imageURLSuffix
    }
    
    public var requestSuffixURL:String {
        return config.urls.requestURLSuffix
    }
}
