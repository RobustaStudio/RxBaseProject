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

enum MiniCashAPI {
    
    //MARK:- General
    case validateAppVersion(version:String)
}

extension MiniCashAPI: TargetType, AccessTokenAuthorizable {
    
    var path: String {
        switch self {
        case .validateAppVersion(_):
            return "/api/check_ios_version"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .validateAppVersion(let version):
            return ["version":version]
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
        return JSONEncoding.default
    }
    
    var base:String {return AppSetup.shared.url }
    var baseURL: URL {
        switch self {
//        case .newRequest(_):
//            return URL(string: "http://requestb.in")!
        default:
            return URL(string: base)!
        }
        
    }
    
    public var task: Task {
        switch self {
        default:
            return .request
        }
    }
}
