//
//  Helpers.swift
//
//
//  Created by Ahmed Mohamed Fareed on 2/15/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import SVProgressHUD

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

// MARK: - Static Functions
public class Helpers {
    
    public static func showMessage(title:String, description:String, timer:Bool = false, completion:(()->())? = nil) {
        if description == "" { return }
        
        let alert = UIAlertController(title: NSLocalizedString(title, comment: ""), message: NSLocalizedString(description, comment: ""), preferredStyle: .alert)
        
        if timer {
            
        }else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .cancel, handler:  { (button) in
                if let block = completion {
                    block()
                }
            }))
        }
        DispatchQueue.main.async {
            Helpers.currentViewController()?.view.endEditing(true)
            Helpers.currentViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showLoadingProgress() {
        //        DispatchQueue.main.async {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        //        }
    }
    
    public static func dismissLoadingProgress() {
        //        DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        //        }
    }
    
    public static func currentViewController() -> UIViewController? {
        return UIApplication.shared.windows.first?.rootViewController
    }
}


// MARK:- Helpers RxExtention
extension ObservableType {
    //    func dismissKeyboard() -> Observable<E> {
    //        return self.do(onNext: { (_) in
    //            Helpers.dismissKeyboard()
    //        })
    //    }
    
    public func showLoadingView() -> Observable<E> {
        return self.do(onNext: { (_) in
            Helpers.showLoadingProgress()
        })
    }
    
    public func dismissLoadingView() -> Observable<E> {
        return self.do(onNext: { (_) in
            Helpers.dismissLoadingProgress()
        }, onError: { (_) in
            Helpers.dismissLoadingProgress()
        })
    }
    
}
