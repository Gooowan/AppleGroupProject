//
//  GenreDisplayConfigView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import SnapKit

class LanguageDisplayView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose language:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let languageSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.insertSegment(withTitle: "ENG", at: 0, animated: true)
        control.insertSegment(withTitle: "UA", at: 1, animated: true)
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        [textLabel, languageSegmentedControl].forEach(stack.addArrangedSubview(_:))
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
            $0.edges.equalToSuperview().inset(5)
        }
    }
}
