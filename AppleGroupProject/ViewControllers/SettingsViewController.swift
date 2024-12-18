//
//  SettingsViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    private let settingsContainerView: UIView = {
        InfoContainerView()
    }()
    
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
        setupNavBar()
        setupUI()
    }
    
    private func setupNavBar() {
        title = "Settings"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        view.addSubview(settingsContainerView)
        
        settingsContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(300)
        }
        
        settingsContainerView.addSubview(genreDisplayView)
        
        genreDisplayView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(5)
            $0.height.equalTo(60)
        }
        
        settingsContainerView.addSubview(languageDisplayView)
        
        languageDisplayView.snp.makeConstraints {
            $0.top.equalTo(genreDisplayView.snp.bottom)
            $0.leading.trailing.equalTo(genreDisplayView)
        }
        
        settingsContainerView.addSubview(themeDisplayView)
        
        themeDisplayView.snp.makeConstraints {
            $0.top.equalTo(languageDisplayView.snp.bottom)
            $0.leading.trailing.equalTo(genreDisplayView)
        }
    }
}
