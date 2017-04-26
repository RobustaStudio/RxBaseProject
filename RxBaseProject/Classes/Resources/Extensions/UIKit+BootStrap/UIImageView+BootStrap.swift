//
//  UIImageView+loadImage.swift
//  HitchHiker
//
//  Created by Mahmoud Eldesouky on 11/17/16.
//  Copyright © 2016 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// takes an url and provied an animated loading progress while
    /// fetching the image from API
    ///
    /// - Parameters:
    ///   - url: url to be fetched
    func loadImage(url:URL?) {
        guard let `url` = url else {
            return
        }
        let activity = UIActivityIndicatorView()
        self.addSubview(activity)
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[activity]-|", options: [], metrics: nil, views: ["activity":activity])
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[activity]-|", options: [], metrics: nil, views: ["activity":activity])
        NSLayoutConstraint.activate(constraints)
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: { (progress, done) in
            }, completionHandler: { (image, error, cacheType, url) in
                if error == nil {
                    self.image = image
                }
                
                DispatchQueue.main.async {
                    activity.stopAnimating()
                    activity.removeFromSuperview()
                    self.layoutIfNeeded()
                }
        })
    }
}
