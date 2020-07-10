//
//  MainViewController.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        let article = articles[indexPath.row]
        
        cell.titleLabel.text =  article.title
        cell.subtitleLabel.text =  article.description
        
        DispatchQueue.main.async {
            if let url = URL(string: article.urlToImage) {
                if let data = try? Data(contentsOf: url) {
                    cell.imageOfArticle.image = UIImage(data: data)
                    cell.imageOfArticle.layer.cornerRadius = cell.imageOfArticle.frame.size.height / 2
                    cell.imageOfArticle.clipsToBounds = true
                }
            }
        }
       // cell.imageOfArticle.image = URL(article.urlToImage)
      //  cell.imageOfArticle.layer.cornerRadius = cell.imageOfArticle.frame.size.height / 2
       // cell.imageOfArticle.clipsToBounds = true
        
        return cell
    }
    


}
