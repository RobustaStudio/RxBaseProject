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


public enum SessionStatus: Int {
    case active
    case inActive
}

public protocol SessionServiceType {
    static var shared:SessionServiceType {get}
    var shouldForceLoggout:Driver<Bool> {get}
    var status:SessionStatus {get}
    var isValid:Bool {get}
    var accessTokenIsValid:Bool {get}
    var xToken:String?  {get}
    // functions
    
    func update(loggedIn:Bool)
    func login()
    func logout()
    func forceLogout(title:String, message:String)
    
    func refreshToken()
    func beforeLogoutHandler()
    func afterLoginHandler()
}

public class SessionService: SessionServiceType {
    var accessToken:BaseTokenModel?
    
    public static var shared:SessionServiceType = SessionService()
    
    public var shouldForceLoggout = Driver<Bool>.empty()
    
    public var xToken:String? {
        if self.accessTokenIsValid {
            return accessToken?.accessToken!
        }
        return nil
    }
    
    public var accessTokenIsValid:Bool {
        guard let at = accessToken else { return false }
        return at.isValid
    }
    
    public var status:SessionStatus {
        let userDefaults = UserDefaults.standard
        if userDefaults.bool(forKey: "user_is_logged_in") {
            return .active
        }else {
            return .inActive
        }
    }
    
    public var isValid:Bool {
        if self.status == .active {
            return true
        }
        return false
    }
    
    let forceLogout = Variable<Bool>(false)
    
    init() {
        shouldForceLoggout = forceLogout.asDriver()
    }
    
    public func update(loggedIn:Bool) {
        let userDefaults = UserDefaults.standard
        if self.isValid {
            if !loggedIn && (accessToken != nil  && accessToken!.isValid ) {
                forceLogout.value = true
            }else {
                forceLogout.value = false
            }
        }
        userDefaults.set(loggedIn, forKey: "user_is_logged_in")
        
        if !loggedIn {
            accessToken = nil
        }
    }
    
    func smoothLogout() {
        accessToken?.invalidate()
        self.update(loggedIn: false)
    }
}

extension SessionService {
    public func refreshToken() {}
    
    public func afterLoginHandler() {}
    
    public func beforeLogoutHandler() {}
    
    public func login() {
        self.update(loggedIn: true)
        afterLoginHandler()
    }
    
    public func logout() {
        beforeLogoutHandler()
        self.smoothLogout()
    }
    
    public func forceLogout(title:String, message:String) {
        self.update(loggedIn: false)
        Helpers.showMessage(title: title.localized, description: message.localized)
    }
}