//
//  SettingsPopupViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 18.12.2024.
//

import UIKit
import SnapKit


class SettingsPopupViewController: UIViewController {

    private let genreDisplayView: UIView = {
        GenreDisplayView()
    }()
    
    private let languageDisplayView: UIView = {
        LanguageDisplayView()
    }()
    
    private let themeDisplayView: UIView = {
        ThemeDisplayView()
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true

        view.addSubview(settingsLabel)
        view.addSubview(closeButton)
        view.addSubview(genreDisplayView)
        view.addSubview(languageDisplayView)
        view.addSubview(themeDisplayView)

        settingsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }

        closeButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.right.equalToSuperview().inset(10)
        }

        genreDisplayView.snp.makeConstraints {
            $0.top.equalTo(settingsLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(60)
        }

        languageDisplayView.snp.makeConstraints {
            $0.top.equalTo(genreDisplayView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(genreDisplayView)
        }

        themeDisplayView.snp.makeConstraints {
            $0.top.equalTo(languageDisplayView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(genreDisplayView)
        }
    }

    @objc private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
