//
//  NewsListTableViewCell.swift
//  RxBaseProject
//
//  Created by Ahmed Mohamed Fareed on 4/26/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    @IBOutlet weak var cellImageView: UIImageView!

    @IBOutlet weak var cellTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func configure(viewModel: NewListCellViewModelType) {
        cellTitleLabel.text = viewModel.title
        cellImageView.loadImage(url: viewModel.url)
    }

    
}
