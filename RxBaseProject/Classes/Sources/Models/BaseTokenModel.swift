//
//  TokenModel.swift
//  
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import ObjectMapper

private extension Date {
    var isInPast: Bool {
        let now = Date()
        return self.compare(now) == ComparisonResult.orderedAscending
    }
}

public class BaseTokenModel: BaseModel {
    
    public var accessToken: String?
    public var tokenType: String?
    public var expirationDate = Date()
    public var refreshToken: String?
    
    static var shared:BaseTokenModel? {
        guard let token = BaseTokenModel.getStoredObject(forKey: UserDefaultsKeys.currentSession.rawValue) as? BaseTokenModel else {
            return nil
        }
        return token
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        refreshToken <- map["refresh_token"]
        
        var expiresInInterval:Int = 0
        expiresInInterval <- map["expires_in"]
        expirationDate.addTimeInterval(TimeInterval(expiresInInterval))
    }
    
    var isValid: Bool {
        return accessToken != nil && !expirationDate.isInPast
    }
    
    //MARK:- Model Coding Managing
    
    public func save() {
        self.store(self, withKey: UserDefaultsKeys.currentSession.rawValue)
    }
    
    public override func encodeData(with aCoder: NSCoder) {
        super.encodeData(with: aCoder)
        aCoder.encode(self.accessToken  , forKey: "access_token")
        aCoder.encode(self.tokenType    , forKey: "token_type")
        aCoder.encode(self.expirationDate    , forKey: "expiration_date")
        aCoder.encode(self.refreshToken , forKey: "refresh_token")
    }
    
    public override func decodeData(coder aDecoder: NSCoder) {
        super.decodeData(coder: aDecoder)
        if let accessToken  = aDecoder.decodeObject(forKey: "access_token") as? String {
            self.accessToken = accessToken
        }
        if let tokenType    = aDecoder.decodeObject(forKey: "token_type") as? String {
            self.tokenType = tokenType
        }
        if let expirationDate    = aDecoder.decodeObject(forKey: "expiration_date") as? Date {
            self.expirationDate = expirationDate
        }
        if let refreshToken = aDecoder.decodeObject(forKey: "refresh_token") as? String {
            self.refreshToken = refreshToken
        }
    }

    func invalidate() {
        BaseTokenModel.deleteObject(forKey: UserDefaultsKeys.currentSession.rawValue)
    }
}
