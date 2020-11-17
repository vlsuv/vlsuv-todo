//
//  ViewController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    // MARK: - Properties
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Glad to see you!"
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSAttributedString(string: "Login", attributes: [
            NSAttributedString.Key.foregroundColor: Colors.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ])
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.backgroundColor = Colors.baseBlue
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.alpha = 0.5
        button.isEnabled = false
        return button
    }()
    
    private let registrationPageButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSMutableAttributedString(string: "Dont have an account? ", attributes: [
            NSAttributedString.Key.foregroundColor: Colors.mediumGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)
            ])
        normalAttributedString.append(NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedString.Key.foregroundColor : Colors.baseBlue,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .light)
            ]))
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.addTarget(self, action: #selector(showRegistationPage), for: .touchUpInside)
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
        
        configureNavigationController()
        setupInputElements()
        setupRegistrationPageButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkUserAuth()
    }
    
    // MARK: - Actions
    @objc private func handleLogin() {
        UserManager.signIn(email: emailTextField.text!, password: passwordTextField.text!) { [weak self] error in
            if let error = error {
                self?.showErrorLabel(errorMessage: error.localizedDescription)
                return
            }

            self?.showListsPage()
        }
    }
    
    @objc private func showRegistationPage() {
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
    
    @objc private func handleTextInputChange() {
        if emailTextField.text != "" &&
            passwordTextField.text != "" {
            loginButton.isEnabled = true
            loginButton.alpha = 1
        } else {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        }
    }
    
    // MARK: - Helpers
    private func checkUserAuth() {
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            if user != nil {
                self?.showListsPage()
            }
        }
    }
    
    private func showListsPage() {
        let controller = UINavigationController(rootViewController: ListsController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
        
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func showErrorLabel(errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }
    
    // MARK: - Handlers
    private func configureNavigationController() {
        navigationController?.isTransparent()
    }
    
    private func setupInputElements() {
        let stackView = UIStackView(arrangedSubviews: [headerTitle, emailTextField, passwordTextField, loginButton, errorLabel])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        loginButton.anchor(height: Sizes.buttonHeight)
        loginButton.layer.cornerRadius = Sizes.cornerRadius
    }
    
    private func setupRegistrationPageButton() {
        view.addSubview(registrationPageButton)
        registrationPageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrationPageButton.anchor(bottom: view.bottomAnchor, paddingBottom: 40)
    }
}
