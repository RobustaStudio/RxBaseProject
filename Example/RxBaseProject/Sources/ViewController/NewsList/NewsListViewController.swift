//
//  NewsListViewController.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import RxBaseProject
import RxSwift
import RxCocoa
import RxDataSources

class NewsListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel:ExampleViewModelType = ExampleViewModel()
    let dataSource = RxTableViewSectionedReloadDataSource<NewListSection>()
    let refreshControl: UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.reloadTrigger.onNext(())
    }
    
    override func configureView() {
        super.configureView()
        self.title = "News List"
        self.tableView = tableView.then {
            $0.register(Reusable.newsCell)
            $0.rowHeight = 95
            $0.allowsSelection = false
            $0.addSubview(self.refreshControl)
        }
        
        self.dataSource.configureCell = { x, tableView, indexPath, viewModel in
            let cell = tableView.dequeue(Reusable.newsCell, for: indexPath)
            cell.configure(viewModel: viewModel)
            return cell
        }
    }
    
    override func configureRx() {
        super.configureRx()
        
        self.rx.viewWillAppear
            .bindTo(viewModel.viewWillAppear)
            .addDisposableTo(self.disposeBag)
        
        
        self.refreshControl.rx
            .controlEvent(.valueChanged)
            //            .filter({ self.refreshControl.isRefreshing }) -> Causes Memory leak
            .bindTo(self.viewModel.reloadTrigger)
            .addDisposableTo(self.disposeBag)
        
        
        viewModel.sections.asObservable().subscribe{[weak self] _ in
            self?.refreshControl.endRefreshing()
            }.addDisposableTo(self.disposeBag)
        
        viewModel.sections
            .drive(self.tableView.rx.items(dataSource: self.dataSource))
            .addDisposableTo(self.disposeBag)
        
        viewModel.tableViewPlaceholderText.drive(onNext: { [weak self] (text) in
            self?.tableView.placeholderText = text
        }).addDisposableTo(self.disposeBag)
    }
}
