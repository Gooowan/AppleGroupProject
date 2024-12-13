//
//  QuoteCell.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit
import SnapKit

class QuoteCell: UITableViewCell {
    
    static let reuseID = "QuoteCell"

    private let containerView: QuoteCellContainerView = {
        QuoteCellContainerView()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    init() {
        super.init(style: .default, reuseIdentifier: Self.reuseID)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.left.right.equalToSuperview().inset(10)
        }
    }
    
    func configure(quote: Quote) {
        containerView.configure(quote: quote)
    }
}
