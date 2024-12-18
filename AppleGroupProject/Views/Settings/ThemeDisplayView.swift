//
//  ThemeDisplayView.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 18.12.2024.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class ThemeDisplayView: UIView {
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Dark theme:"
        label.textColor = .label
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.lineBreakMode = .byCharWrapping
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        label.applyTextTheme()
        return label
    }()
    
    private let settingSwitch: UISwitch = {
        let newSwitch = UISwitch()
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
        applySecondaryBackgroundTheme()
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .secondarySystemBackground
        
        settingSwitch.addTarget(self, action: #selector(didChangeSwitch), for: .touchUpInside)
        settingSwitch.isOn = AppConfig.shared.theme == .dark ? true : false
        settingSwitch.isOnPublisher
            .sink { isOn in
                AppConfig.shared.theme = isOn ? .dark : .light
            }
            .store(in: &cancellables)

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
    
    @objc func didChangeSwitch() {
        self.bounceAnimation(scale: 1.05, duration: 0.1)
    }
}
