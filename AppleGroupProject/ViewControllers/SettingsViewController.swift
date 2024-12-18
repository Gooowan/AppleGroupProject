//
//  SettingsViewController.swift
//  AppleGroupProject
//
//  Created by Ivan Solomatin on 17.12.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .gray
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private let quoteCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        updateUIForLoggedInState()
    }
    
    private func setupNavBar() {
        title = "Profile"
        view.backgroundColor = .systemBackground
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonTapped)
        )
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsPopupViewController()
        settingsVC.modalPresentationStyle = .popover
        present(settingsVC, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(quoteCountLabel)
        view.addSubview(loginStackView)
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        profileImageView.layer.cornerRadius = 50
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        quoteCountLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        loginStackView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    private func updateUIForLoggedInState() {
        // Example logic to check login state
        let isLoggedIn = false // Replace with actual login state logic
        
        if isLoggedIn {
            usernameLabel.text = "Username: JohnDoe" // Replace with actual username
            quoteCountLabel.text = "Quotes: 42"      // Replace with actual quote count
            loginStackView.isHidden = true
        } else {
            usernameLabel.text = nil
            quoteCountLabel.text = nil
            loginStackView.isHidden = false
            
            let emailTextField = UITextField()
            emailTextField.placeholder = "Email"
            emailTextField.borderStyle = .roundedRect
            
            let passwordTextField = UITextField()
            passwordTextField.placeholder = "Password"
            passwordTextField.borderStyle = .roundedRect
            passwordTextField.isSecureTextEntry = true
            
            let loginButton = UIButton(type: .system)
            loginButton.setTitle("Login", for: .normal)
            loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
            
            loginStackView.addArrangedSubview(emailTextField)
            loginStackView.addArrangedSubview(passwordTextField)
            loginStackView.addArrangedSubview(loginButton)
        }
    }
    
    @objc private func handleLogin() {
        // Handle login logic here
        print("Login button tapped")
    }
}
