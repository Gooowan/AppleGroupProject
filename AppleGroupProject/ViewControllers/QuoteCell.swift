//
//  QuoteCell.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit
import Combine

class QuoteCell: UITableViewCell {

    private let quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private var cancellables: Set<AnyCancellable> = []

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(quoteLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(genreLabel)
        setupLayout()
        setupBindings()
    }
    
    private func setupBindings() {
        AppConfig.shared.$isGenresHidden
            .sink { [weak self] isHidden in
                self?.genreLabel.textColor = isHidden ? UIColor.systemBlue : UIColor.clear
                print(isHidden)
            }
            .store(in: &cancellables)
    }
    
    private func setupLayout() {
        quoteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(quoteLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(18)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }

    func configure(with quote: Quote) {
        quoteLabel.text = "\"\(quote.text)\""
        genreLabel.text = "\(quote.genre)"
        authorLabel.text = "- \(quote.author)"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
