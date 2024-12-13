//
//  QuotesListController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 11.12.2024.
//

import UIKit
import SnapKit

private let quotes: [Quote] = [
    Quote(text: "United we stand. Divided we fall", author: "Captain America", color: .purple, category: .inspiration),
    Quote(text: "You must be the change you wish to see in the world", author: "Mahatma Gandhi", color: .blue, category: .history),
    Quote(text: "The only thing we have to fear is fear itself", author: "Franklin D. Roosevelt", color: .yellow, category: .politics),
    Quote(text: "Darkness cannot drive out darkness: only light can do that. Hate cannot drive out hate: only love can do that", author: "Martin Luther King Jr.", color: .orange, category: .politics),
    Quote(text: "Well done is better than well said", author: "Benjamin Franklin", color: .yellow, category: .motivation)
]

class QuoteListController: UIViewController {
    
    private var segmentedControlView: CategorySegmentedControlView = {
        CategorySegmentedControlView(items: QuoteCategory.self)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        searchController.searchBar.placeholder = "Search for a quote..."
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupUI() {
        [segmentedControlView, tableView].forEach(view.addSubview(_:))
        
        segmentedControlView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentedControlView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(segmentedControlView)
            $0.bottom.equalToSuperview()
        }
    }
}

extension QuoteListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuoteCell.reuseID, for: indexPath)
                as? QuoteCell else { return UITableViewCell() }
        cell.configure(quote: quotes[indexPath.row])
        return cell
    }
}

extension QuoteListController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {

    }
}
