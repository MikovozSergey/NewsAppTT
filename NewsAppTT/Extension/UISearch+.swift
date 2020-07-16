import UIKit

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {

        filteredNews = articles.filter { $0.title.contains(searchController.searchBar.text ?? "") }

        tableView.reloadData()
    }
}
