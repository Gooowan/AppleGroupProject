//
//  AddQuoteViewController.swift
//  AppleGroupProject
//
//  Created by Andrii Klykavka on 17.12.2024.
//

import UIKit
import SnapKit

class AddQuoteViewController: UIViewController {
    
    private let quoteTextFieldContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var quoteTextView: UITextView = {
        let textView = UITextView()
        textView.borderStyle = .none
        textView.backgroundColor = .secondarySystemBackground
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.tintColor = UIColor.label
        textView.textColor = UIColor.label
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavBar()
        setupUI()
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
        print("Save a quote")
        self.dismiss(animated: true)
    }
    
    private func setupUI() {
        view.addSubview(quoteTextFieldContainerView)
        
        quoteTextFieldContainerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(200)
        }
        
        quoteTextFieldContainerView.addSubview(quoteTextView)
        quoteTextFieldContainerView.addSubview(separatorView)
        quoteTextFieldContainerView.addSubview(authorTextField)
        
        quoteTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(120)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(quoteTextView.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(0.5)
        }
        
        authorTextField.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom).offset(6)
            $0.leading.trailing.equalTo(quoteTextView)
            $0.height.equalTo(20)
        }
    }
}