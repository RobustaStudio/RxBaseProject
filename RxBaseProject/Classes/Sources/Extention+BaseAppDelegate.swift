//
//  Extention+BaseAppDelegate.swift
//  MiniCash
//
//  Created by Ahmed Mohamed Fareed on 2/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import SVProgressHUD

extension BaseAppDelegate {
    func login() {
        APIManager.shared.isLoggedIn(bool: true)
    }
    func logout() {
        TokenModel.invalidate()
        APIManager.shared.isLoggedIn(bool: false)
    }
    func forceLogOut(message:String?) {
        self.logout()
    }
}


// MARK: - Static Functions
extension BaseAppDelegate {
    
    public static var shared:BaseAppDelegate {
        return (UIApplication.shared.delegate as! BaseAppDelegate)
    }
    
    static func showMessage(title:String, description:String, timer:Bool = false) {
        if description == "" { return }
        
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(description, comment: ""), preferredStyle: .alert)
        
        if timer {
            
        }else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler: nil))
        }
        DispatchQueue.main.async {
            BaseAppDelegate.currentViewController()?.view.endEditing(true)
            BaseAppDelegate.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showLoadingProgress() {
        DispatchQueue.main.async {
            BaseAppDelegate.dismissKeyboard()
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
        }
    }
    
    static func dismissLoadingProgress() {
        DispatchQueue.main.async {
            BaseAppDelegate.dismissKeyboard()
            SVProgressHUD.dismiss()
        }
    }
    
    static func dismissKeyboard() {
        BaseAppDelegate.currentViewController()?.view.endEditing(true)
    }
    
    static func currentViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
