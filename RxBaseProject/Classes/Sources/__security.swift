//
//  __security.swift
//  Pods
//
//  Created by Ahmed Magdi on 7/4/17.
//
//

import Foundation

public protocol ConfigSecurity {
    var clientIdKey:String       {get}
    var clientSecretKey:String   {get}
    var appTokenKey:String       {get}
    
    var clientIdValue:String     {get}
    var clientSecretValue:String {get}
    var appTokenValue:String     {get}
    
    var usingAppToken:Bool {get}
}


class __security: ConfigSecurity {
    
    var appTokenKey:String       = "app_token"
    var appTokenValue:String     = ""
    
    var clientIdKey:String       = "client_id"
    var clientIdValue:String     = ""
    
    var clientSecretKey:String   = "client_secret"
    var clientSecretValue:String = ""
    
    var usingAppToken:Bool = false
    
    convenience init?(configurations con:[AppConfigurations:Any]) {
        if con[.clientIdValue] != nil {
            self.init(clientId: con[AppConfigurations.clientIdValue] as? String,
                       clientSecret: con[AppConfigurations.clientSecretValue] as? String,
                       clientIdKey: con[AppConfigurations.clientIdKey] as? String,
                       clientSecretKey: con[AppConfigurations.clientSecretKey] as? String)
        } else if con[.clientIdValue] != nil {
            self.init(appToken: con[AppConfigurations.appTokenValue] as? String, tokenKey: con[AppConfigurations.appTokenKey] as? String)
        } else {
            return nil
        }
    }
    
    init(clientId:String?, clientSecret:String?, clientIdKey:String?=nil, clientSecretKey:String?=nil) {
        self.usingAppToken = false
        
        guard let `clientId` = clientId, clientId != "" , let `clientSecret` = clientSecret, clientSecret != "" else {
            fatalError("Please check, client_id and client_secret can not be nil")
        }
        
        self.clientIdValue = clientId
        self.clientSecretValue = clientSecret
        
        if let idKey = clientIdKey {
            self.clientIdKey = idKey
        }
        
        if let secretKey = clientSecretKey {
            self.clientSecretKey = secretKey
        }
    }
    
    init(appToken:String?, tokenKey:String?=nil) {
        guard let token = appToken, token != ""  else {
            fatalError("AppToken Can't be empty")
        }
        
        self.appTokenValue = token
        
        self.usingAppToken = true
        if let tKey = tokenKey {
            self.appTokenKey = tKey
        }
    }
}
