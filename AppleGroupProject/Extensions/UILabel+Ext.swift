//
//  UILabel+Ext.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import Combine

extension UILabel {
    
    private static var extensionCancellables: Set<AnyCancellable> = []
    
    func applyTextTheme() {
        AppConfig.shared.$theme
            .sink { [weak self] theme in
                self?.textColor = ThemeManager.textColor(for: theme)
            }
            .store(in: &UILabel.extensionCancellables)
    }
    
    func applySecondaryTextTheme() {
        AppConfig.shared.$theme
            .sink { [weak self] theme in
                self?.textColor = ThemeManager.secondaryTextColor(for: theme)
            }
            .store(in: &UILabel.extensionCancellables)
    }
}
