//
//  InfoContainerView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit

class InfoContainerView: UIView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        applySecondaryBackgroundTheme()
        layer.masksToBounds = false
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
    }
}
