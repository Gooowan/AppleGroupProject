//
//  LogoView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit

class LogoImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        self.image = UIImage(named: "logo")
        contentMode = .scaleAspectFit
    }
}
