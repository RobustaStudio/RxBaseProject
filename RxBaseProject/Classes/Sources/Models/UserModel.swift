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

class UserModel: MiniCashModel {
    static var sharedObservable:Variable<UserModel?> = Variable<UserModel?>(nil)
    
    var accessToken:TokenModel? {
        return TokenModel.shared
    }
    
    static var shared:UserModel? {
        guard let me = UserModel.getStoredObject(forKey: "me") as? UserModel else {
            return nil
        }
        if UserModel.sharedObservable.value == nil {
            UserModel.sharedObservable.value = me
        }
        return me
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
    
    func save() {
        self.store(self, withKey: "me")
        UserModel.sharedObservable.value = self
    }
    
    static func invalidate() {
        TokenModel.deleteObject(forKey: "me")
    }
}
