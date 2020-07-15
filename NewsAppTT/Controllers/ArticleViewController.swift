//
//  ArticleViewController.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/15/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {
    
    var article: Article!
  
    @IBOutlet var articleImage: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleDescription: UILabel!
    @IBOutlet var notificationLabel: UILabel!
    @IBOutlet var articleAuthor: UILabel!
    @IBOutlet var articleSourceName: UILabel!
    @IBOutlet var articlePublishedAt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTitle.text = article.title
        articleDescription.text = article.description
        notificationLabel.text = "You cannot see the full content of the article, as it is included in the paid version of NewsApi."
        articleAuthor.text = article.author
        articleSourceName.text = article.sourceName
        articlePublishedAt.text = article.publishedAt
        
        if let url = URL(string: article.urlToImage) {
            if let data = try? Data(contentsOf: url) {
                articleImage.image = UIImage(data: data)
            }
        }
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {


    }
    

}
