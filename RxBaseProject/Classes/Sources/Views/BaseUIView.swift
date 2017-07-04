//
//  BaseUIView.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 2/27/17.
//  Copyright © 2017 Ahmed Mohamed Magdi. All rights reserved.
//

import UIKit

class BaseUIView: UIView  {
    var xibName:String { return "" }
    
    @IBOutlet weak var contentView:UIView?
    
    override init(frame: CGRect) { // for using CustomView in code
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using CustomView in IB
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(xibName, owner: self, options: nil)
        guard let content = contentView else { return }
        content.frame = self.bounds
        content.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(content)
        configureView()
    }
    
    func configureView() {}
    func configureRx() {}
}
