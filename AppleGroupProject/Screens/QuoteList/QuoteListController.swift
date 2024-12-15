//
//  QuotesListController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 11.12.2024.
//

import UIKit
import SnapKit

private let quoteStorage: [Quote] = [
    Quote(text: "United we stand. Divided we fall", author: "Captain America", color: .purple, category: .inspiration),
    Quote(text: "You must be the change you wish to see in the world", author: "Mahatma Gandhi", color: .blue, category: .history),
    Quote(text: "The only thing we have to fear is fear itself", author: "Franklin D. Roosevelt", color: .yellow, category: .politics),
    Quote(text: "Darkness cannot drive out darkness: only light can do that. Hate cannot drive out hate: only love can do that", author: "Martin Luther King", color: .orange, category: .politics),
    Quote(text: "Well done is better than well said", author: "Benjamin Franklin", color: .yellow, category: .motivation)
]

class QuoteListController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = CategotyCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseID)
        
        return collectionView
    }()
    
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
            updateEmptyStateView(for: tableView, with: quotes, message: "No quotes were saved yet..")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotes = quoteStorage
        setupNavigationController()
        setupSearchController()
        setupTableHeaderView()
        setupUI()
    }
    
    private func setupNavigationController() {
        navigationItem.titleView = LogoImageView()
        navigationController?.navigationBar.barTintColor = .systemBackground
    }
    
    private func setupSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search for a quote..."
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController

    }
    
    private func setupTableHeaderView() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        headerView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        
        tableView.tableHeaderView = headerView
    }

    private func setupUI() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension QuoteListController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        QuoteCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseID, for: indexPath)
                as? CategoryCell else { return UICollectionViewCell() }
        let category = QuoteCategory.allCases[indexPath.row].rawValue
        cell.set(category)
        return cell
    }
}

extension QuoteListController: UITableViewDelegate, UITableViewDataSource {
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

extension QuoteListController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {

    }
}
