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
    
    private var usernameTextField: UITextField!
    private var passwordTextField: UITextField!
    
    private var isLoggedIn = false
    private var currentUser: User?
    
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
        
        usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        loginStackView.addArrangedSubview(usernameTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(loginButton)
    }
    
    private func updateUIForLoggedInState() {
        if isLoggedIn, let user = currentUser {
            usernameLabel.text = "Username: \(user.username)"
            quoteCountLabel.text = "Created Quotes: \(user.createdQuotes.count)"
            loginStackView.isHidden = true
            profileImageView.tintColor = .systemBlue
        } else {
            usernameLabel.text = nil
            quoteCountLabel.text = nil
            loginStackView.isHidden = false
            profileImageView.tintColor = .gray
        }
    }
    
    @objc private func handleLogin() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        if let user = authenticateUser(username: username, password: password) {
            isLoggedIn = true
            currentUser = user
            updateUIForLoggedInState()
        } else {
            showAlert(message: "Invalid email or password.")
        }
    }
    
    private func authenticateUser(username: String, password: String) -> User? {
        // Mock user database
        let users = [
            User(
                id: "1",
                username: "JohnDoe",
                password: "password123",
                likedQuotes: [
                    Quote(text: "Be yourself; everyone else is already taken.", author: "Oscar Wilde", genre: "Motivational", id: "1")
                ],
                createdQuotes: [
                    Quote(text: "The only limit to our realization of tomorrow is our doubts of today.", author: "Franklin D. Roosevelt", genre: "Inspirational", id: "2")
                ]
            )
        ]
        
        return users.first { $0.username == username && $0.password == password }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
