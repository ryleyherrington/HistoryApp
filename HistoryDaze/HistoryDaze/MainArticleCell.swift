//
//  MainArticleCell.swift
//  HistoryDaze
//
//  Created by Ryley Herrington on 9/7/16.
//  Copyright © 2016 Herrington. All rights reserved.
//

import UIKit

class MainArticleCell: UITableViewCell {

    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
