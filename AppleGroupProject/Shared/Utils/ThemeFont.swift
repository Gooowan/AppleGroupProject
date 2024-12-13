//
//  ThemeFont.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit

struct ThemeFont {
    
    private static let boldItalicDescriptor =
        UIFontDescriptor.preferredFontDescriptor(withTextStyle: .body).withSymbolicTraits([.traitBold, .traitItalic])
    
    static func regular(ofSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return isItalic ? UIFont.italicSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    static func bold(ofSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return isItalic ?
        UIFont(descriptor: boldItalicDescriptor ?? UIFontDescriptor(), size: size) :
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
    static func semibold(ofSize size: CGFloat, isItalic: Bool = false) -> UIFont {
        return isItalic ?
        UIFont(descriptor: boldItalicDescriptor ?? UIFontDescriptor(), size: size) :
        UIFont.systemFont(ofSize: size, weight: .bold)
    }
}
