//
//  BaseModel.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/13/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import ObjectMapper


class BaseModel: NSObject, Mappable, NSCoding {
    
    var details:NSMutableDictionary! = NSMutableDictionary()
    
    override init() { super.init()}
    
    required init?(map: Map) {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        decodeData(coder: aDecoder)
    }
    
    func encode(with aCoder: NSCoder) {
        encodeData(with: aCoder)
    }
    
    // Mappable
    func mapping(map: Map) {}
    
    // Storing
    func decodeData(coder aDecoder: NSCoder) {}
    
    func encodeData(with aCoder: NSCoder) {}
    
    func store(_ object:Any, withKey key:String) {
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getStoredObject(forKey key:String) -> Any? {
        let userDefaults = UserDefaults.standard
        if let session = userDefaults.data(forKey: key), let currentSession = NSKeyedUnarchiver.unarchiveObject(with: session) {
            return currentSession
        }
        return nil
    }
    
    static func deleteObject(forKey key:String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }
    
//
//    // DeepLinking
//    
//    func deepLinkDictionary() -> [AnyHashable: Any] {
//        return [AnyHashable: Any]()
//    }
//    
//    func deeplinkURLParamsString(prefixURL:String) -> URLComponents? {
//        let dictionary = deepLinkDictionary()
//        if dictionary.count > 0 {
//            
//            let params = dictionary.map {(key, value) in URLQueryItem(name: key as! String, value: "\(value)")}
//            var url = URLComponents(string: prefixURL)
//            url?.queryItems = params
//            
//            print("DeepLink URL: \(url)")
//            return url
//        }else {
//            return nil
//        }
//    }
}
