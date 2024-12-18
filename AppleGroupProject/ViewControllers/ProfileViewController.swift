import UIKit
import SnapKit
import Combine

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
        label.applySecondaryTextTheme()
        return label
    }()

    private let quoteCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.applySecondaryTextTheme()
        return label
    }()

    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private var usernameTextField: UITextField = {
        let textField = UITextField()
        let placeholderText = "Username"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ThemeManager.textColor(for: AppConfig.shared.theme)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        textField.borderStyle = .roundedRect
        textField.applySecBackgroundTheme()
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        let placeholderText = "Password"
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: ThemeManager.textColor(for: AppConfig.shared.theme)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        textField.borderStyle = .roundedRect
        textField.applySecBackgroundTheme()
        return textField
    }()

    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupUI()
        addGestures()
        bindEntitiesManager()
        setupBindings()
    }
    
    private func setupBindings() {
        EntitiesManager.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
                if !currentUser.isEmpty {
                    self?.updateUIForLoggedInState()
                } else {
                    self?.updateUIForLoggedOutState()
                }
            }
            .store(in: &cancellables)
    }

    private func setupNavBar() {
        title = "Profile"
        view.applyBackgroundTheme()

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
        settingsVC.modalPresentationStyle = .pageSheet
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func addGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func didTapView() {
        view.endEditing(true)
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
            $0.top.equalTo(quoteCountLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }

        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.setTitleColor(ThemeColor.thirdColor, for: .normal)

        let registerButton = UIButton(type: .system)
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerButton.setTitleColor(ThemeColor.thirdColor, for: .normal)

        let buttonStackView = UIStackView(arrangedSubviews: [loginButton, registerButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10

        loginStackView.addArrangedSubview(usernameTextField)
        loginStackView.addArrangedSubview(passwordTextField)
        loginStackView.addArrangedSubview(buttonStackView)
    }

    private func bindEntitiesManager() {
        EntitiesManager.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] currentUser in
                print("Current user changed: \(currentUser)")
                if currentUser != "UnknownUser" {
                    self?.updateUIForLoggedInState()
                } else {
                    self?.updateUIForLoggedOutState()
                }
            }
            .store(in: &cancellables)
    }

    func updateUIForLoggedInState() {
        guard EntitiesManager.shared.currentUser != "UnknownUser" else {
            updateUIForLoggedOutState()
            return
        }

        print("Searching for current user: \(EntitiesManager.shared.currentUser)")
        guard let user = EntitiesManager.shared.users.first(where: { $0.username == EntitiesManager.shared.currentUser }) else {
            print("No matching user found for \(EntitiesManager.shared.currentUser)")
            updateUIForLoggedOutState()
            return
        }

        print("Updating UI for user: \(user.username)")
        usernameLabel.text = "Username: \(user.username)"
        quoteCountLabel.text = "Created Quotes: \(user.createdQuotes.count)"
        loginStackView.isHidden = true
        profileImageView.tintColor = .systemBlue
    }

    private func updateUIForLoggedOutState() {
        usernameLabel.text = nil
        quoteCountLabel.text = nil
        loginStackView.isHidden = false
        profileImageView.tintColor = .gray
    }

    @objc private func handleLogin() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        EntitiesManager.shared.logUser(user: username, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    EntitiesManager.shared.currentUser = username
                    self.updateUIForLoggedInState()
                } else {
                    self.showAlert(message: "Invalid email or password.")
                }
            }
        }
    }
    
    @objc private func handleRegister() {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }

        if EntitiesManager.shared.users.contains(where: { $0.username == username }) {
            showAlert(message: "This username is already taken.")
            return
        }

        EntitiesManager.shared.regUser(user: username, password: password)
        EntitiesManager.shared.currentUser = username
        
        let alert = UIAlertController(title: "Success", message: "Registration successful. You are now logged in.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        updateUIForLoggedInState()
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
