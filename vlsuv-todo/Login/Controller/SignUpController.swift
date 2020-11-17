//
//  SignUpController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    // MARK: - Properties
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = Colors.darkGray
        return label
    }()
    
    private let emailTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Email")
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    private let passwordTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Password", secureText: true)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    private let confimPasswordTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Confim Password", secureText: true)
        textField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedString.Key.foregroundColor: Colors.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
        ])
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.backgroundColor = Colors.baseBlue
        button.alpha = 0.5
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = Colors.red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationControler()
        setupInputElements()
    }
    
    // MARK: - Actions
    @objc private func handleSignUp() {
        UserManager.createUser(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] error in
            if let error = error {
                self?.showErrorLabel(errorMessage: error.localizedDescription)
                return
            }
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func handleTextInputChange() {
        if emailTextField.text != "" &&
            passwordTextField.text != "" &&
            confimPasswordTextField.text != "" &&
            passwordTextField.text == confimPasswordTextField.text {
            signUpButton.isEnabled = true
            signUpButton.alpha = 1
        } else {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
        }
    }
    
    // MARK: - Helpers
    private func showErrorLabel(errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    // MARK: - Handlers
    private func configureNavigationControler() {
        navigationController?.navigationBar.tintColor = Colors.darkGray
    }
    
    private func setupInputElements() {
        let stackView = UIStackView(arrangedSubviews: [headerTitle, emailTextField, passwordTextField, confimPasswordTextField, signUpButton, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        signUpButton.anchor(height: Sizes.buttonHeight)
        signUpButton.layer.cornerRadius = Sizes.cornerRadius
    }
}
