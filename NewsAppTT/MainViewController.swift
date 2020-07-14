//
//  MainViewController.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var previousIndex: Int = 0
    private var rightNavigationBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load(with: previousIndex)
        setupOptions()
    }
    
    private func setupOptions() {
        
        rightNavigationBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "refresh"), style: .done, target: self, action: #selector(rightNavigationBarButtonTapped))
        navigationItem.rightBarButtonItem = rightNavigationBarButtonItem
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = createButton(with: "Load more")
    }
    
    private func createButton(with title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 20
        button.setTitle(title, for: .normal)
        button.backgroundColor = .gray
        button.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        button.layer.shadowRadius = 5.0
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
        button.clipsToBounds = false
        button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
        return button
    }
    
    @objc private func rightNavigationBarButtonTapped() {
        previousIndex = 0
        load(with: previousIndex)
    }

    func load(with index: Int){
        loadNews(with: index) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        previousIndex += 1
        load(with: previousIndex)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let article = articles[indexPath.row]
        
        cell.configure(with: article)
        cell.showMoreDidTapHandler = { 
            articles[indexPath.row].isHiddenShowMoreButton.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? ArticleViewController)?.article = articles[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
}
