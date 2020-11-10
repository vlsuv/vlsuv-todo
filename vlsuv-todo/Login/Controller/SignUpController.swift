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
    let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textColor = Colors.darkGray
        return label
    }()
    
    let emailTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Email")
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Password", secureText: true)
        return textField
    }()
    
    let confimPasswordTextField: BaseLoginTextField = {
        let textField = BaseLoginTextField(name: "Confim Password", secureText: true)
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSAttributedString(string: "Sign Up", attributes: [
            NSAttributedString.Key.foregroundColor: Colors.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ])
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.backgroundColor = Colors.baseBlue
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationControler()
        setupInputElements()
    }
    
    // MARK: - SignUp Actions
    @objc private func handleSignUp() {
        
    }
    
    // MARK: - Handlers
    private func configureNavigationControler() {
        navigationController?.navigationBar.tintColor = Colors.darkGray
    }
    
    private func setupInputElements() {
        let stackView = UIStackView(arrangedSubviews: [headerTitle, emailTextField, passwordTextField, confimPasswordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 40
        
        view.addSubview(stackView)
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 30, paddingRight: 30)
        
        signUpButton.anchor(height: Sizes.buttonHeight)
        signUpButton.layer.cornerRadius = Sizes.cornerRadius
    }
}
