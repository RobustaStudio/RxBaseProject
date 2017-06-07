//
//  OnlineProvider.swift
//  Alamofire
//
//  Created by Ahmed Magdi on 6/7/17.
//

import Foundation
import Moya
import RxSwift

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

