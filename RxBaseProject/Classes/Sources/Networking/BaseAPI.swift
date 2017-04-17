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

fileprivate let VERSION = AppSetup.shared.version

protocol BaseType {
    var addAppAuth: Bool { get }
}

enum BaseAPI {}

extension BaseAPI: TargetType, AccessTokenAuthorizable, BaseType {
    var path: String {
        switch self {
        default:
            return ""
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
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
        switch self {
        default:
            return true
        }
    }
    
    var addAppAuth: Bool {
        switch self {
        default:
            return false
        }
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        switch self {
//        case .updateMyImage(let profileImage):
//            guard let data = UIImageJPEGRepresentation(profileImage, 0.1) else { return nil }
//            let formData:Moya.MultipartFormData = Moya.MultipartFormData(provider: .data(data), name: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
//            return [formData]
        default:
            return []
        }
    }

    public var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
    var base:String {return AppSetup.shared.UsingStaging ? AppSetup.shared.StagingURL : AppSetup.shared.ProductionURL }
    var baseURL: URL {
        switch self {
        default:
            return URL(string: base)!
        }
        
    }
    
    public var task: Task {
        switch self {
//        case .updateMyImage(_):
//            return .upload(.multipart(multipartBody ?? []))
        default:
            return .request
        }
    }
}

// MARK: - Provider support

func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}

func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}
