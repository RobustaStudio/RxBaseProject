//
//  AppSetup.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

public class AppSetup {
    
    public static let shared = AppSetup()
    
    private var dicData:[String: Any]!
    
    init() {
        if let path = Bundle.main.path(forResource: "AppData", ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                self.dicData = dic
            }else {
                fatalError("Plist file isn't structure correctly")
            }
        }else {
            fatalError("Index Is Invalid")
        }
    }
    
    
    
    
    public var UsingAppToken:Bool {
        return dicData["UsingAppToken"] as! Bool
    }
    
    public var UsingStaging:Bool {
        return dicData["UsingStaging"] as! Bool
    }
    
    public var version :String {
        return dicData["version"] as! String
    }
    
    public var UsingStubbed:Bool {
        return dicData["UsingStubbed"] as! Bool
    }
    
    public var AllowRefreshToken:Bool {
        return dicData["AllowRefreshToken"] as! Bool
    }
    
    public var AppSecurity:String {
        return dicData["AppSecurity"] as! String
    }
    
    public var clientId:String {
        return dicData["clientId"]as! String
    }
    
    public var clientSecret:String {
        return dicData["clientSecret"]as! String
    }
    
    public var AppToken:String {
        return dicData["AppToken"]as! String
    }
    
    public var BaseURLs:String {
        return dicData["BaseURLs"]as! String
    }
    
    public var StagingURL:String {
        return dicData["StagingURL"]as! String
    }
    
    public var ProductionURL:String {
        return dicData["ProductionURL"]as! String
    }
    
    public var ImageURLSuffix:String {
        return dicData["ImageURLSuffix"]as! String
    }
}
