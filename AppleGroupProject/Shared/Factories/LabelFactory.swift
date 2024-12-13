//
//  LabelFactory.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 12.12.2024.
//

import UIKit

final class LabelFactory {
    static func
    build(
        text: String? = nil,
        font: UIFont,
        textColor: UIColor,
        textAlignment: NSTextAlignment
    ) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        return label
    }
}
