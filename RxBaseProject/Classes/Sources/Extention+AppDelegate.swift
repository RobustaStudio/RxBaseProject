//
//  Extention+AppDelegate.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import SVProgressHUD

extension AppDelegate {
    public func login() {
        APIManager.shared.isLoggedIn(bool: true)
    }
    public func logout() {
        TokenModel.invalidate()
        APIManager.shared.isLoggedIn(bool: false)
    }
    public func forceLogOut(message:String?) {
        self.logout()
    }
}


// MARK: - Static Functions
extension AppDelegate {
    
    public static var shared:AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    public static func showMessage(title:String, description:String, timer:Bool = false) {
        if description == "" { return }
        
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(description, comment: ""), preferredStyle: .alert)
        
        if timer {
            
        }else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            AppDelegate.currentViewController()?.view.endEditing(true)
            AppDelegate.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showLoadingProgress() {
        DispatchQueue.main.async {
            AppDelegate.dismissKeyboard()
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
    }
    
    public static func dismissLoadingProgress() {
        DispatchQueue.main.async {
            AppDelegate.dismissKeyboard()
            SVProgressHUD.dismiss()
        }
    }
    
    public static func dismissKeyboard() {
        AppDelegate.currentViewController()?.view.endEditing(true)
    }
    
    public static func currentViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
