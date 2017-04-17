//
//  Response+Data.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/24/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import Moya
import ObjectMapper

extension ObservableType where E == Moya.Response {
    
//    func mapObjectToGenResponse<T: BaseMappable>(_ type: T.Type) -> Observable<GenericResponse<T>> {
//        return self.mapObject(T.self).map({ (object) -> GenericResponse<T> in
//            return GenericResponse<T>(object: object)
//        }).catchError({ (error) -> Observable<GenericResponse<T>> in
//            return Observable.just(GenericResponse<T>(error: error as! MoyaError))
//        })
//    }
//    
//    func mapArrayToGenResponse<T: BaseMappable>(_ type: T.Type) -> Observable<GenericResponse<T>> {
//        return self.mapArray(T.self).map({ (object) -> GenericResponse<T> in
//            return GenericResponse<T>(object: object)
//        }).catchError({ (error) -> Observable<GenericResponse<T>> in
//            return Observable.just(GenericResponse<T>(error: error as! MoyaError))
//        })
//    }

}
