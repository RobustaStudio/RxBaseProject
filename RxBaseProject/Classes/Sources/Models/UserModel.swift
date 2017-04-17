//
//  UserEntity.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift

public class UserModel: MiniCashModel {
    public static var sharedObservable:Variable<UserModel?> = Variable<UserModel?>(nil)
    
    public var accessToken:TokenModel? {
        return TokenModel.shared
    }
    
    public static var shared:UserModel? {
        guard let me = UserModel.getStoredObject(forKey: "me") as? UserModel else {
            return nil
        }
        if UserModel.sharedObservable.value == nil {
            UserModel.sharedObservable.value = me
        }
        return me
    }
    
   public  override func mapping(map: Map) {
        super.mapping(map: map)
    }
    
    public func save() {
        self.store(self, withKey: "me")
        UserModel.sharedObservable.value = self
    }
    
    public static func invalidate() {
        TokenModel.deleteObject(forKey: "me")
    }
}
