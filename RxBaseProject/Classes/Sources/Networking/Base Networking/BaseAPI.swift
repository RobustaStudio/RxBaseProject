//
//  BaseAPI.swift
//  Alamofire
//
//  Created by Ahmed Magdi on 6/7/17.
//

import Foundation
import Moya

public protocol BaseAPI: TargetType, AccessTokenAuthorizable {
    var stubbedStatusCode:Int {get}
}

extension BaseAPI {
    public var baseURL: URL {
        return URL(string: Config.shared.url)!
    }
}


