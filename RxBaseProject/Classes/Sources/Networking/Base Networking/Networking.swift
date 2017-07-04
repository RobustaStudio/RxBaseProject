//
//  Networking.swift
//
//
//  Created by Ahmed Mohamed Fareed on 2/5/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.


import Foundation
import Moya
import RxSwift
import Alamofire
import RxOptional
import SVProgressHUD

private func newProvider<T>(_ type:T.Type, _ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T>  {
    return OnlineProvider(endpointClosure: Networking<T>.endpointsClosure(xAccessToken),
                          requestClosure: Networking<T>.endpointResolver(),
                          stubClosure: Networking<T>.APIStubBehaviour,
                          plugins: plugins)
}

protocol NetworkingType {
    associatedtype T: BaseAPI
    var provider: OnlineProvider<T> { get }
}

public struct Networking<API>: NetworkingType where API: BaseAPI {
    
    public let provider: OnlineProvider<API>
    let disposeBag = DisposeBag()
    
    public static func `default`(allowExtensiveDebuging:Bool=false) -> Networking<API> {
        var plugins:[PluginType] = []
        if allowExtensiveDebuging {
            plugins = [NetworkLoggerPlugin(verbose: false)]
        }
        return Networking(provider: newProvider(T.self,plugins))
    }
    
    /// Request to fetch and store new XApp token if the current token is missing or expired.
    ///
    /// - Returns: Observable of accessToken or nil
    private func refreshAccessToken() -> Observable<Bool> {
        
        // If we have a valid token, return it and forgo a request for a fresh one.
        if SessionService.shared.xToken != nil  {
            return Observable.just(false)
        }
        
        if SessionService.shared.refreshToken != nil {
            return SessionService.shared.refreshToken!().map({ (accessToken) -> Bool in
                return true
            })
        }
        else {
            return Observable.just(false)
        }
    }
    
    /// Request to fetch a given target. Ensures that valid XApp tokens exist before making request
    public func request(_ target: API) -> Observable<Response> {
        let responseObservable = self.provider.request(target)
        
        if !target.shouldAuthorize {
            return responseObservable
                .filterSuccessfulStatusCodes()
                .debug()
        }
        
        return responseObservable.flatMapLatest { (response) -> Observable<Response> in
            switch response.statusCode {
            case 401:
                if !Config.shared.usingRefreshToken {
                    SessionService.shared.update(status: .sessionExpired)
                    return Observable.just(response)
                }
                
                return self.refreshAccessToken().flatMapLatest({ (authenticated) -> Observable<Response> in
                    if authenticated {
                        return self.provider.request(target)
                    }
                    SessionService.shared.update(status: .sessionExpired)
                    return Observable.just(response)
                })
            default:
                return Observable.just(response)
            }
            }.filterSuccessfulStatusCodes().debug()
    }
}

//MARK:- Static NetworkingType methods
extension NetworkingType {
    
    // TODO:- Check if there was security in the app then add the securityData
    // TODO:- 
    // TODO:- 
    
    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint<T> where T: BaseAPI {
        return { target in
            
            let endpoint: Endpoint<T> = Endpoint<T>(url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                                                    sampleResponseClosure:  {.networkResponse(target.stubbedStatusCode, target.sampleData)},
                                                    method: target.method,
                                                    parameters: target.parameters,
                                                    parameterEncoding: target.parameterEncoding,
                                                    httpHeaderFields: target.headers)
            
            // If we were given an xAccessToken, add it
            if let xAccessToken = SessionService.shared.xToken {
                return endpoint.adding(httpHeaderFields: ["Authorization": "Bearer \(xAccessToken)"])
            }
            
            // non-XAuth token requests
            guard let _security = Config.shared.security else {return endpoint}
            
            if _security.usingAppToken {
                return endpoint.adding(httpHeaderFields: [_security.appTokenKey:_security.appTokenValue])
            }else {
                return endpoint.adding(httpHeaderFields: [_security.clientIdKey:_security.clientIdValue, _security.clientSecretKey:_security.clientSecretValue])
            }
        }
    }
    
    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver<T>() -> MoyaProvider<T>.RequestClosure where T: TargetType {
        return { (endpoint, closure) in
            var request = endpoint.urlRequest!
            request.httpShouldHandleCookies = false
            closure(.success(request))
        }
    }
    
    static func APIStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return Config.shared.usingStubbed ? .immediate : .never
    }
}
