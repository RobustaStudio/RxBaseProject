//
//  MiniCashAPI.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/2/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Moya_ObjectMapper
import ObjectMapper
import Alamofire


import RxBaseProject

enum SampleAPI {
    
    //MARK:- General
    case newsList()
}

extension SampleAPI: BaseAPI {
    
    var path: String {
        switch self {
        case .newsList():
            return "/svc/books/v3/lists/overview.json"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .newsList():
            return ["api-key":"c1ffa36662824925a52c83559b03b290"]
        default:
            return nil
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        default:
            return Data(base64Encoded: "{\"status\":{ \"code\": 200, \"message\": \"success\" }")!
        }
    }
    
    var shouldAuthorize: Bool {
        return false
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        return []
    }

    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .newsList():
            return URLEncoding.default
        default:
            return JSONEncoding.default

        }
    }
    
    var baseURL: URL {
        switch self {
        default:
            return URL(string: "https://api.nytimes.com")!
        }
        
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
}
