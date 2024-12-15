//
//  CategoryCell.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 15.12.2024.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    static let reuseID = "CategoryCell"
    
    private let titleLabel: UILabel = {
        LabelFactory.build(
            font: ThemeFont.semibold(ofSize: 16),
            textColor: ThemeColor.secondaryText,
            textAlignment: .center)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(_ text: String) {
        titleLabel.text = text
    }
}
