//
//  SessionService.swift
//  Pods
//
//  Created by Ahmed Mohamed Fareed on 4/24/17.
//
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Alamofire

public enum UserDefaultsKeys:String {
    case currentUser = "rxProject_user_key"
    case currentSession = "rxProject_current_session"
}

private enum PrivateUserDefaultsKeys:String {
    case isUserLoggedIn = "rxProject_user_is_logged_in"
}


public enum SessionStatus: Int {
    case active
    case inActive
    case sessionExpired
}

public protocol SessionServiceType {
    
    static var shared:SessionServiceType {get}
    var sessionStatus:Variable<SessionStatus> {get}
    //var status:SessionStatus {get}
    var isValid:Bool {get}
    var accessTokenIsValid:Bool {get}
    var xToken:String?  {get}
    var user: BaseModel? { get }
    var refreshToken:(()->(Observable<String?>))? {get set}

    // functions
    func update(status:SessionStatus)

//    func update(loggedIn:Bool)
    func userLoggedIn<T:BaseModel>(user:T, type:T.Type)//, accessToken:BaseTokenModel)
}

public class SessionService: SessionServiceType {
    
    public var refreshToken:(()->(Observable<String?>))?
    
    var tokenModel:BaseTokenModel? {
        return BaseTokenModel.getStoredObject(forKey: UserDefaultsKeys.currentSession.rawValue) as? BaseTokenModel
    }
    
    public static var shared:SessionServiceType = SessionService()
    
    public var sessionStatus:Variable<SessionStatus>
    
    public var user: BaseModel? {
        get {
            return BaseModel.getStoredObject(forKey: UserDefaultsKeys.currentUser.rawValue) as? BaseModel
        }
        set {}
    }
    
    public var refreshTokenCode:String? {
        return tokenModel?.refreshToken
    }
    
    public var xToken:String? {
        if self.accessTokenIsValid {
            return tokenModel?.accessToken!
        }
        return nil
    }
    
    public var accessTokenIsValid:Bool {
        guard let xtoken = tokenModel else { return false }
        return xtoken.isValid
    }
    
    public var isValid:Bool {
        if self.status == .active {
            return true
        }
        return false
    }
    
    var status:SessionStatus {
        let userIsLoggedIn = UserDefaults.standard.bool(forKey: PrivateUserDefaultsKeys.isUserLoggedIn.rawValue)
        //let tokenStillValid = self.accessTokenIsValid
        
        if !userIsLoggedIn  {
            return .inActive
        }else {
            return .active
        }
    }
    
    init() {
        let userIsLoggedIn = UserDefaults.standard.bool(forKey: PrivateUserDefaultsKeys.isUserLoggedIn.rawValue)
        
        if !userIsLoggedIn  {
            sessionStatus = Variable<SessionStatus>(.inActive)
        }else {
            sessionStatus = Variable<SessionStatus>(.active)
        }
    }
    
    public func update(status:SessionStatus) {
        let userDefaults = UserDefaults.standard
        switch status {
        case .active:
            userDefaults.set(true, forKey: PrivateUserDefaultsKeys.isUserLoggedIn.rawValue)
        case .inActive:
            userDefaults.set(false, forKey: PrivateUserDefaultsKeys.isUserLoggedIn.rawValue)
        case .sessionExpired:
            userDefaults.set(false, forKey: PrivateUserDefaultsKeys.isUserLoggedIn.rawValue)
        }
        
        sessionStatus.value = status
    }

    public func userLoggedIn<T:BaseModel>(user:T, type:T.Type) {
        self.update(status:.active)
        self.user = user
    }
}
