//
//  EmptyStateView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 15.12.2024.
//

import UIKit
import SnapKit

class EmptyStateView: UIView {
    
    private let titleLabel: UILabel = {
        let label = LabelFactory.build(
            text: "New Era",
            font: ThemeFont.semibold(ofSize: 24, isItalic: true),
            textColor: ThemeColor.secondaryText,
            textAlignment: .center)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(message: String) {
        titleLabel.text = message
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
}
