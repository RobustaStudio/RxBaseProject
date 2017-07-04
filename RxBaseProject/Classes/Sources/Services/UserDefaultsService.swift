//
//  UserDefaultsService.swift
//  Pods
//
//  Created by Ahmed Magdi on 7/4/17.
//
//

import Foundation


class UserDefaultsService {
    
    static func retrieveObject(forKey key:String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.value(forKey:key)
    }
    
    static func storeObject(object:Any?, forKey key:String) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
    
    
}
