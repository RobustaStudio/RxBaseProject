//
//  BaseModel.swift
//  
//
//  Created by Ahmed Mohamed Fareed on 2/13/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import ObjectMapper


open class BaseModel: NSObject, Mappable, NSCoding {
    
    public var details:NSMutableDictionary! = NSMutableDictionary()
    
    public override init() { super.init()}
    
    required public init?(map: Map) {}
    
    required public init?(coder aDecoder: NSCoder) {
        super.init()
        decodeData(coder: aDecoder)
    }
    
    public func encode(with aCoder: NSCoder) {
        encodeData(with: aCoder)
    }
    
    // Mappable
    open func mapping(map: Map) {}
    
    // Storing
    open func decodeData(coder aDecoder: NSCoder) {}
    
    open func encodeData(with aCoder: NSCoder) {}
    
    public func store(_ object:Any, withKey key:String) {
        let userDefaults = UserDefaults.standard
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: object)
        userDefaults.set(encodedData, forKey: key)
        userDefaults.synchronize()
    }
    
    public static func getStoredObject(forKey key:String) -> Any? {
        let userDefaults = UserDefaults.standard
        if let session = userDefaults.data(forKey: key), let currentSession = NSKeyedUnarchiver.unarchiveObject(with: session) {
            return currentSession
        }
        return nil
    }
    
    public static func deleteObject(forKey key:String) {
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: key)
    }
    

    // DeepLinking
    func deepLinkDictionary() -> [AnyHashable: Any] {
        return [AnyHashable: Any]()
    }
    
    func deeplinkURLParamsString(prefixURL:String) -> URLComponents? {
        let dictionary = deepLinkDictionary()
        if dictionary.count > 0 {
            let params = dictionary.map {(key, value) in URLQueryItem(name: key as! String, value: "\(value)")}
            var url = URLComponents(string: prefixURL)
            url?.queryItems = params
            return url
        }else {
            return nil
        }
    }
}
