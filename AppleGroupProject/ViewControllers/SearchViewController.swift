//
//  SearchViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text, author, or genre"
        textField.borderStyle = .roundedRect
        textField.applySecBackgroundTheme()
        return textField
    }()

    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(ThemeColor.thirdColor, for: .normal)
        return button
    }()

    private let tableView = UITableView()
    var allQuotes: [Quote] = EntitiesManager.shared.quotes
    var filteredQuotes: [Quote] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Quotes"

        setupUI()
        addGestures()
        searchButton.addTarget(self, action: #selector(performSearch), for: .touchUpInside)
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tap)
        tableView.addGestureRecognizer(tap)
    }
    
    @objc private func didTapScreen() {
        view.endEditing(true)
    }

    private func setupUI() {
        view.applyBackgroundTheme()
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.applyBackgroundTheme()

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
        guard let query = searchTextField.text else {
            filteredQuotes = EntitiesManager.shared.quotes
            tableView.reloadData()
            return
        }
        
        filteredQuotes = EntitiesManager.shared.searchQuotes(query: query)
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
