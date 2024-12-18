//
//  HomeScreenViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit
import Combine

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var savedQuotes: [Quote] = []
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        setupTableView()
        ObserverChanges()
    }

    private func ObserverChanges() {
        EntitiesManager.shared.$quotes
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedQuotes in
                self?.savedQuotes = updatedQuotes
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        AppConfig.shared.$isGenresHidden
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func setupNavBar() {
        title = "All Quotes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        let controller = AddQuoteViewController()
        controller.delegate = self
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .formSheet
        self.present(navController, animated: true)
    }
    
    private func setupUI() {
        view.applyBackgroundTheme()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.applyBackgroundTheme()

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedQuotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }

        let quote = savedQuotes[indexPath.row]
        cell.configure(with: quote)
        return cell
    }
    
    @objc private func handleQuoteAdded(notification: Notification) {
        if let quote = notification.userInfo?["quote"] as? Quote {
            savedQuotes.append(quote)
            tableView.insertRows(at: [IndexPath(row: savedQuotes.count - 1, section: 0)], with: .automatic)
        }
    }
}

extension HomeScreenViewController: AddQuoteDelegate {
    func didAddQuote(_ quote: Quote) {
        savedQuotes = EntitiesManager.shared.quotes
        tableView.reloadData()
    }
}
