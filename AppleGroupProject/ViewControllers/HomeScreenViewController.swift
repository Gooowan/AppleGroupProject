//
//  HomeScreenViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView = UITableView()
    var savedQuotes: [Quote] = [
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs", genre: "Business"),
        Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon", genre: "Life"),
        Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill", genre: "Motivation")
    ]


    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        view.backgroundColor = .white
        setupTableView()
        
    }
    
    private func setupNavBar() {
        title = "Saved Quotes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        let controller = AddQuoteViewController()
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .formSheet
        self.present(navController, animated: true)
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

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
}
