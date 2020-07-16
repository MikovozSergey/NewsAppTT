//
//  MainViewController.swift
//  NewsAppTT
//
//  Created by Дарья Станкевич on 7/10/20.
//  Copyright © 2020 Sergey Mikovoz. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil) // using the same view
    
    var filteredNews: [Article] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var previousIndex: Int = 0
    private var rightNavigationBarButtonItem: UIBarButtonItem!
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load(with: previousIndex)
        setupOptionsForRefreshButton()
        
        // setup the searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true

    }
    
    private func setupOptionsForRefreshButton() {
        rightNavigationBarButtonItem = UIBarButtonItem(image: UIImage(imageLiteralResourceName: "refresh"), style: .done, target: self, action: #selector(rightNavigationBarButtonTapped))
        navigationItem.rightBarButtonItem = rightNavigationBarButtonItem
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = createButton(with: "Load more")
    }
    
    private func createButton(with title: String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 40))
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 0
        //button.layer.cornerRadius = 20
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(rgb: 0x3996FB)
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
        if isFiltering {
            return filteredNews.count
        }
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell

        var article : Article?
        
        if isFiltering {
            article = filteredNews[indexPath.row]
        } else {
            article = articles[indexPath.row]
        }
        
        cell.configure(with: article!)
        cell.showMoreDidTapHandler = { 
            articles[indexPath.row].isHiddenShowMoreButton.toggle()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        return cell
    }
    
    // Animations for cells
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -300, 0, 0)
        cell.layer.transform = translationTransform
        
        UIView.animate(withDuration: 1, delay: 0.2, options: .curveEaseOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticle", sender: self)
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showArticle" {
            if let indexPath = tableView.indexPathForSelectedRow {
                (segue.destination as? ArticleViewController)?.article = articles[indexPath.row]
                tableView.deselectRow(at: indexPath, animated: true)
                
                var article : Article?
                if isFiltering {
                    article = filteredNews[indexPath.row]
                } else {
                    article = articles[indexPath.row]
                }

            }
        }
    }
}


