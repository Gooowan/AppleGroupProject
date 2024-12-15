//
//  CategotyCollectionViewFlowLayout.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 15.12.2024.
//

import UIKit

class CategotyCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        scrollDirection = .horizontal
        itemSize = CGSize(width: 120, height: 40)
        minimumLineSpacing = 10
        
    }
}
