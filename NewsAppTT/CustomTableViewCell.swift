//
//  CustomTableViewCell.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var imageOfArticle: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    @IBAction func showMoreAction(_ sender: Any) {
    }
    
}
