//
//  SearchViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - UI Components
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text, author, or genre"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()

    private let tableView = UITableView()

    // MARK: - Data
    var allQuotes: [Quote] = [
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs", genre: "Business"),
        Quote(text: "Life is what happens when you're busy making other plans.", author: "John Lennon", genre: "Life"),
        Quote(text: "Success is not final, failure is not fatal: it is the courage to continue that counts.", author: "Winston Churchill", genre: "Motivation"),
        Quote(text: "Innovation distinguishes between a leader and a follower.", author: "Steve Jobs", genre: "Technology")
    ]

    var filteredQuotes: [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Quotes"
        view.backgroundColor = .white

        setupUI()
        searchButton.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
    }

    private func setupUI() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100

        // Layout constraints
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc private func performSearch() {
        guard let query = searchTextField.text?.lowercased(), !query.isEmpty else {
            filteredQuotes = allQuotes
            tableView.reloadData()
            return
        }

        filteredQuotes = allQuotes.filter { quote in
            quote.text.lowercased().contains(query) ||
            quote.author.lowercased().contains(query) ||
            quote.genre.lowercased().contains(query)
        }
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredQuotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as? QuoteCell else {
            return UITableViewCell()
        }

        let quote = filteredQuotes[indexPath.row]
        cell.configure(with: quote)
        return cell
    }
}
