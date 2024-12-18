//
//  AddQuoteViewController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 17.12.2024.
//

import UIKit
import SnapKit

protocol AddQuoteDelegate: AnyObject {
    func didAddQuote(_ quote: Quote)
}

class AddQuoteViewController: UIViewController {
    
    weak var delegate: AddQuoteDelegate?

    private let quoteTextFieldContainerView: UIView = {
        InfoContainerView()
    }()
    
    private var quoteTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .secondarySystemBackground
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.tintColor = UIColor.label
        textView.textColor = UIColor.label
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var firstSeparatorView: UIView = {
        SeparatorView()
    }()
    
    private var authorTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Author..."
        field.borderStyle = .none
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.tintColor = UIColor.label
        field.textColor = UIColor.label
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private var secondSeparatorView: UIView = {
        SeparatorView()
    }()

    private var genreTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Genre (e.g., Inspiration, Love, Humor)"
        field.borderStyle = .none
        field.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        field.tintColor = UIColor.label
        field.textColor = UIColor.label
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupUI()
        setupAccessibilityIdentifiers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quoteTextView.becomeFirstResponder()
    }
    
    private func setupNavBar() {
        title = "Add Quote"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "pencil.slash")!, style: .done, target: self, action: #selector(closeButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func saveButtonTapped() {
        guard let text = quoteTextView.text, !text.isEmpty,
              let author = authorTextField.text, !author.isEmpty,
              let genre = genreTextField.text, !genre.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields: quote, author, and genre.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        let quoteConstruct = QuoteCreationStruct(username: author, text: text, genre: genre)
        EntitiesManager.shared.addQuote(quoteArg: quoteConstruct)
        
        let alert = UIAlertController(title: "Success", message: "Your quote has been saved!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(quoteTextFieldContainerView)
        
        quoteTextFieldContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(280)
        }
        
        quoteTextFieldContainerView.addSubview(quoteTextView)
        quoteTextFieldContainerView.addSubview(firstSeparatorView)
        quoteTextFieldContainerView.addSubview(authorTextField)
        quoteTextFieldContainerView.addSubview(secondSeparatorView)
        quoteTextFieldContainerView.addSubview(genreTextField)
        
        quoteTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(150)
        }
        
        firstSeparatorView.snp.makeConstraints {
            $0.top.equalTo(quoteTextView.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(0.5)
        }
        
        authorTextField.snp.makeConstraints {
            $0.top.equalTo(firstSeparatorView.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(50)
        }
        
        secondSeparatorView.snp.makeConstraints {
            $0.top.equalTo(authorTextField.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(0.5)
        }
        
        genreTextField.snp.makeConstraints {
            $0.top.equalTo(secondSeparatorView.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(50)
        }
    }
    
    private func setupAccessibilityIdentifiers() {
        navigationItem.leftBarButtonItem?.accessibilityIdentifier = "closeButton"
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "saveButton"
        quoteTextView.accessibilityIdentifier = "quoteTextView"
        authorTextField.accessibilityIdentifier = "authorTextField"
        genreTextField.accessibilityIdentifier = "genreTextField"
        quoteTextFieldContainerView.accessibilityIdentifier = "quoteContainerView"
    }
}
