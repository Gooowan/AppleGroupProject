//
//  QuoteCategory.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit

enum QuoteColor {
    case white
    case red
    case blue
    case green
    case yellow
    case purple
    case orange
    
    func getUIColor() -> UIColor {
        switch self {
        case .white:
            UIColor.white
        case .red:
            UIColor.systemRed
        case .blue:
            UIColor.systemBlue
        case .green:
            UIColor.systemGreen
        case .yellow:
            UIColor.systemYellow
        case .purple:
            UIColor.systemPurple
        case .orange:
            UIColor.systemOrange
        }
    }
}
