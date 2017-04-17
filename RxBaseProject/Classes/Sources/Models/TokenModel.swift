//
//  TokenModel.swift
//  MiniCash
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

public class TokenModel: MiniCashModel {
    
    public var accessToken: String?
    public var tokenType: String?
    public var expiresIn: Int?
    public var refreshToken: String?
    
    public static var shared:TokenModel? {
        guard let token = TokenModel.getStoredObject(forKey: "current_session") as? TokenModel else {
            return nil
        }
        return token
    }
    
    public override func mapping(map: Map) {
        super.mapping(map: map)
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        expiresIn <- map["expires_in"]
        refreshToken <- map["refresh_token"]
    }
    
    public var isValid: Bool {
        return (accessToken != nil )
    }
    
    //MARK:- Model Coding Managing
    
    public func save() {
        self.store(self, withKey: "current_session")
    }
    
    public override func encodeData(with aCoder: NSCoder) {
        super.encodeData(with: aCoder)
        aCoder.encode(self.accessToken  , forKey: "access_token")
        aCoder.encode(self.tokenType    , forKey: "token_type")
        aCoder.encode(self.expiresIn    , forKey: "expires_in")
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
        if let expiresIn    = aDecoder.decodeObject(forKey: "expires_in") as? Int {
            self.expiresIn = expiresIn
        }
        if let refreshToken = aDecoder.decodeObject(forKey: "refresh_token") as? String {
            self.refreshToken = refreshToken
        }
    }

    public static func invalidate() {
        TokenModel.deleteObject(forKey: "current_session")
        UserModel.invalidate()
    }
}
