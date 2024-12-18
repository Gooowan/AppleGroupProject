//
//  ThemeManager.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit

class ThemeManager {
    
    static func backgroundColor(for theme: Theme) -> UIColor {
        switch theme {
        case .light:
            return ThemeColor.lightBg
        case .dark:
            return ThemeColor.darkBg
        }
    }
    
    static func secondaryBackgroundColor(for theme: Theme) -> UIColor {
        switch theme {
        case .light:
            return ThemeColor.lightSecBg
        case .dark:
            return ThemeColor.darkSecBg
        }
    }
    
    static func textColor(for theme: Theme) -> UIColor {
        switch theme {
        case .light:
            return ThemeColor.lightText
        case .dark:
            return ThemeColor.darkText
        }
    }
    
    static func secondaryTextColor(for theme: Theme) -> UIColor {
        switch theme {
        case .light:
            return ThemeColor.lightSecText
        case .dark:
            return ThemeColor.darkSecText
        }
    }
}
