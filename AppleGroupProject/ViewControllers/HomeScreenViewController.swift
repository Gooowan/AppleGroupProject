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
    var savedQuotes: [Quote] = EntitiesManager.shared.quotes

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved Quotes"
        view.backgroundColor = .white
        setupTableView()
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
