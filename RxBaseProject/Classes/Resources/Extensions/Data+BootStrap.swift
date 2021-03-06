//
//  Data+BootStrap.swift
//  Pods
//
//  Created by Ahmed Mohamed Fareed on 4/24/17.
//
//

import Foundation
extension Data {
    public static func stubbedResponse(jsonFileName filename: String) -> Data! {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle.main//(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
}
