//
//  AppSetup.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

class AppSetup {
    
    static let shared = AppSetup()
    
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
    
    
    
    
    var UsingAppToken:Bool {
        return dicData["UsingAppToken"] as! Bool
    }
    
    var UsingStaging:Bool {
        return dicData["UsingStaging"] as! Bool
    }
    
    var version :String {
        return dicData["version"] as! String
    }
    
    var UsingStubbed:Bool {
        return dicData["UsingStubbed"] as! Bool
    }
    
    var AllowRefreshToken:Bool {
        return dicData["AllowRefreshToken"] as! Bool
    }
    
    var AppSecurity:String {
        return dicData["AppSecurity"] as! String
    }
    
    var clientId:String {
        return dicData["clientId"]as! String
    }
    
    var clientSecret:String {
        return dicData["clientSecret"]as! String
    }
    
    var AppToken:String {
        return dicData["AppToken"]as! String
    }
    
    var BaseURLs:String {
        return dicData["BaseURLs"]as! String
    }
    
    var StagingURL:String {
        return dicData["StagingURL"]as! String
    }
    
    var ProductionURL:String {
        return dicData["ProductionURL"]as! String
    }
    
    var ImageURLSuffix:String {
        return dicData["ImageURLSuffix"]as! String
    }
}
