//
//  UIViewController+Ext.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 15.12.2024.
//

import UIKit

extension UIViewController {
    func updateEmptyStateView(for tableView: UITableView, with data: [Any], message message: String) {
        if data.isEmpty {
            let emptyStateView = EmptyStateView(frame: tableView.bounds)
            emptyStateView.set(message: message)
            tableView.backgroundView = emptyStateView
        } else {
            tableView.backgroundView = nil
        }
    }
}
