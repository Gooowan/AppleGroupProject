//
//  AppConfig.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import Combine

final class AppConfig {
    static let shared = AppConfig()
    
    private init() {}
    
    @Published var isGenresHidden: Bool = true
    @Published var theme: Theme = .light {
        didSet {
            print("Theme changed")
        }
    }
}

enum Theme {
    case light
    case dark
}
