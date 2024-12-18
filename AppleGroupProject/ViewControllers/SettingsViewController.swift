//
//  SettingsViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit

class SettingsViewController: UIViewController {

    private let showGenresLabel: UILabel = {
        let label = UILabel()
        label.text = "Show Genres"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    private let showGenresSwitch: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .white
        setupUI()
        loadSettings()
        showGenresSwitch.addTarget(self, action: #selector(toggleGenres), for: .valueChanged)
    }

    private func setupUI() {
        view.addSubview(showGenresLabel)
        view.addSubview(showGenresSwitch)

        showGenresLabel.translatesAutoresizingMaskIntoConstraints = false
        showGenresSwitch.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            showGenresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showGenresLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            showGenresSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showGenresSwitch.centerYAnchor.constraint(equalTo: showGenresLabel.centerYAnchor)
        ])
    }

    @objc private func toggleGenres() {
        UserDefaults.standard.set(showGenresSwitch.isOn, forKey: "ShowGenres")
    }

    private func loadSettings() {
        let showGenres = UserDefaults.standard.bool(forKey: "ShowGenres")
        showGenresSwitch.isOn = showGenres
    }
}
