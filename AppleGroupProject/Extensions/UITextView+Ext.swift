//
//  UITextView+Ext.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import Combine

extension UIView {
    
    private static var extensionCancellables: Set<AnyCancellable> = []
    
    func applySecBackgroundTheme() {
        AppConfig.shared.$theme
            .sink { [weak self] theme in
                self?.backgroundColor = ThemeManager.secondaryBackgroundColor(for: theme)
            }
            .store(in: &UIView.extensionCancellables)
    }
}
