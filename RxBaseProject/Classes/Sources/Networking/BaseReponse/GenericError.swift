//
//  GenericError.swift
//
//
//  Created by Ahmed Mohamed Fareed on 2/18/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import ObjectMapper


public class GenericError: NSObject {
    
    public static let ErrorMessage = NSLocalizedString("Something went wrong, Try again later", comment: "")
    
    public var statusCode:Int = 0
    public var errorMessage:String = ""
    public var errorDic: [String:Any]?
    
    public var errorObject:BaseErrorModel?
    
    public init(error:MoyaError) {
        super.init()
        self.handleFailure(error: error)
    }
    
    private func handleFailure(error:MoyaError?) {
        
        if error == nil {
            errorMessage = GenericError.ErrorMessage
            self.statusCode = -1
            return
        }
        
        guard let response = error?.response else {
            statusCode = 0
            errorMessage = error?.errorDescription ?? GenericError.ErrorMessage
            return
        }
        
        self.statusCode = response.statusCode
        
        switch statusCode {
        case 401:
            if let data = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as! [String:Any] {
                self.errorMessage = data["error_description"] as? String ?? ""
                if(self.errorMessage == "") {
                    self.errorMessage = data["error_message_sentence"] as? String ?? ""
                }
            }else {
                self.errorMessage = response.description
            }
            
            // call refresh token
            ///SessionService.shared.update(loggedIn: false)
            return
        case 500...599:
            errorMessage = GenericError.ErrorMessage
            break
        case 400...499:
            if let data = try? JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as! [String:Any] {
                var message = ""
                data.forEach{ message = "\(message)\n\($0)"}
                self.errorMessage = message
                self.errorDic = data
            }
            break
        default:
            break
        }
    }
}
