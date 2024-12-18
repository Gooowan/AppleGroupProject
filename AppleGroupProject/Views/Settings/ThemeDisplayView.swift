//
//  ThemeDisplayView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import SnapKit

class ThemeDisplayView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark theme:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let settingSwitch: UISwitch = {
        let newSwitch = UISwitch()
        newSwitch.isOn = false
        return newSwitch
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        [textLabel, settingSwitch].forEach(stack.addArrangedSubview(_:))
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
