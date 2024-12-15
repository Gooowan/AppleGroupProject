//
//  SearchController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 11.12.2024.
//

import UIKit
import SnapKit

class SearchController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
        tableView.register(QuoteCell.self, forCellReuseIdentifier: QuoteCell.reuseID)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private var quotes: [Quote] = [] {
        didSet {
            self.updateEmptyStateView(for: tableView, with: quotes, message: "Search for quotes here...")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        quotes = []
        setupNavigationController()
        setupSearchController()
        setupUI()
    }
    
    private func setupNavigationController() {
        navigationItem.titleView = LogoImageView()
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.reuseID, for: indexPath)
                as? QuoteCell else { return UITableViewCell() }
        cell.set(quote: quotes[indexPath.row])
        return cell
    }
}

extension SearchController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
