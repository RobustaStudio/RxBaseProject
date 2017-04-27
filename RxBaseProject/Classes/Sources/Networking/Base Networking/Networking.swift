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

public protocol BaseAPI:TargetType, AccessTokenAuthorizable {}


/// Overriding RxMoyaProvider to add custom defaults
public class OnlineProvider<Target>: RxMoyaProvider<Target> where Target: BaseAPI {
    
    fileprivate let online: Observable<Bool>
    
    init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = RxMoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,
         online: Observable<Bool> = connectedToInternetOrStubbing()) {
        
        self.online = online
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    // Override request to inject XAppTokenRequest if needed
    
    
    /// which is responsable for handling all the requests going out/in
    ///
    /// - Parameter token: the request that is required to be sent
    /// - Returns: the response for the sent request
    override public func request(_ token: Target) -> Observable<Moya.Response> {
        
        let actualRequest = super.request(token)
        return online
            .ignore(value: false)  // Wait until we're online
            .take(1)        // Take 1 to make sure we only invoke the API once.
            .flatMap { _ in // Turn the online state into a network request
                return actualRequest
        }
    }
}


protocol NetworkingType {
    associatedtype T: BaseAPI
    
    var provider: OnlineProvider<T> { get }
}

public struct Networking<API>: NetworkingType where API: BaseAPI {
    
    public let provider: OnlineProvider<API>

    /// Request to fetch and store new XApp token if the current token is missing or expired.
    private func XAppTokenRequest() -> Observable<String?> {
        
        // If we have a valid token, return it and forgo a request for a fresh one.
        if let xtoken = SessionService.shared.xToken {
            return Observable.just(xtoken)
        }

        let newTokenRequest:Observable<String?> = Observable.empty()
        
//        let newTokenRequest = self.provider.request(BaseAPI.refreshToken())
//            .filterSuccessfulStatusCodes()
//            .mapJSON()
//            .map { element -> (token: String?, expiry: String?) in
//                guard let dictionary = element as? NSDictionary else { return (token: nil, expiry: nil) }
//                
//                return (token: dictionary["xapp_token"] as? String, expiry: dictionary["expires_in"] as? String)
//            }
//            .do(onNext: { element in
//                // These two lines set the defaults values injected into appToken
//                appToken.token = element.0
//                appToken.expiry = KioskDateFormatter.fromString(element.1 ?? "")
//            })
//            .map { (token, expiry) -> String? in
//                return token
//            }
//            .logError()
        return newTokenRequest
    }

    
    /// Request to fetch a given target. Ensures that valid XApp tokens exist before making request
    func request(_ token: API, model:BaseModel?=nil) -> Observable<Response> {
        let actualRequest = self.provider.request(token)
        
        if token.shouldAuthorize && AppSetup.shared.allowRefreshToken {
            return self.XAppTokenRequest().flatMap { _ in actualRequest }
        }
        
        return actualRequest.asObservable()
            .filterSuccessfulStatusCodes()
//            .do(onError: { (e) in
//                guard let error = e as? Moya.MoyaError else { throw e }
//                let reError = GenericError(error: error)
//                print(reError.errorMessage)
//            })
    }
}

//MARK:- Static NetworkingType methods
extension NetworkingType {
    
    public static func `default`(allowExtensiveDebuging:Bool=false) -> Networking<T> {
        var plugins:[PluginType] = []
        if allowExtensiveDebuging {
            plugins = [NetworkLoggerPlugin(verbose: false)]
        }
        return Networking(provider: newProvider(T.self,plugins))
    }

    static func endpointsClosure<T>(_ xAccessToken: String? = nil) -> (T) -> Endpoint<T> where T: TargetType, T:AccessTokenAuthorizable {
        return { target in
            
            var endpoint: Endpoint<T> = Endpoint<T>(url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                                                    sampleResponseClosure:  {.networkResponse(200, target.sampleData)},
                                                    method: target.method,
                                                    parameters: target.parameters,
                                                    parameterEncoding: target.parameterEncoding)
            
            // If we were given an xAccessToken, add it
            if let xAccessToken = SessionService.shared.xToken {
                endpoint = endpoint.adding(httpHeaderFields: ["Authorization": "Bearer \(xAccessToken)", "Content-Type":"application/json", "Accept":"application/json"])
            }
            
            // non-XAuth token requests
            if target.shouldAuthorize {
                return endpoint.adding(httpHeaderFields:[:])
            } else {
                return endpoint
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
        return AppSetup.shared.usingStubbed ? .immediate : .never
    }
}

private func newProvider<T>(_ type:T.Type, _ plugins: [PluginType], xAccessToken: String? = nil) -> OnlineProvider<T> where T: BaseAPI {
    return OnlineProvider(endpointClosure: Networking<T>.endpointsClosure(xAccessToken),
                          requestClosure: Networking<T>.endpointResolver(),
                          stubClosure: Networking<T>.APIStubBehaviour,
                          plugins: plugins)
}
