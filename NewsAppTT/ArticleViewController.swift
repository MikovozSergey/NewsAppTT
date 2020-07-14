//
//  ArticleViewController.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article!
    
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleDescription: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTitle.text = article.title
        articleDescription.text = article.description
    }
    
    
}
