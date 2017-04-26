//
//  ViewController.swift
//  RxBaseProject
//
//  Created by ahmed93 on 04/11/2017.
//  Copyright (c) 2017 ahmed93. All rights reserved.
//

import UIKit
import RxBaseProject

class ViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel:ExampleViewModelType = ExampleViewModel()
    

    override func configureRx() {
        super.configureRx()
        
        self.rx.viewWillAppear
            .bindTo(viewModel.viewWillAppear)
            .addDisposableTo(self.disposeBag)
        
        
    }
    
}

