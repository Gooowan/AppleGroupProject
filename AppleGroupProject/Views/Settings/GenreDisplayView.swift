//
//  GenreDisplayConfigView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class GenreDisplayView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Display Genres:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let settingSwitch: UISwitch = {
        let newSwitch = UISwitch()
        newSwitch.isOn = true
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
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        settingSwitch.isOn = AppConfig.shared.isGenresHidden
        
        settingSwitch.isOnPublisher
            .sink { isOn in
                AppConfig.shared.isGenresHidden = isOn
            }
            .store(in: &cancellables)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
