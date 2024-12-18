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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    private func setupUI() {
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.applyBackgroundTheme()

        view.addSubview(genreDisplayView)
        view.addSubview(languageDisplayView)
        view.addSubview(themeDisplayView)

        genreDisplayView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(20)
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
}
