//
//  ViewController.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    // MARK: - Properties
    let headerTitle: UILabel = {
        let label = UILabel()
        label.text = "Glad to see you!"
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
    
    let loginButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSAttributedString(string: "Login", attributes: [
            NSAttributedString.Key.foregroundColor: Colors.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
            ])
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.backgroundColor = Colors.baseBlue
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let registrationPageButton: UIButton = {
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

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        
        configureNavigationController()
        setupInputElements()
        setupRegistrationPageButton()
    }
    
    // MARK: - Login Actions
    @objc private func handleLogin() {
        let controller = UINavigationController(rootViewController: ListsController())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: false)
    }
    
    @objc private func showRegistationPage() {
        navigationController?.pushViewController(SignUpController(), animated: true)
    }
    
    // MARK: - Handlers
    private func configureNavigationController() {
        navigationController?.isTransparent()
    }
    
    private func setupInputElements() {
        let stackView = UIStackView(arrangedSubviews: [headerTitle, emailTextField, passwordTextField, loginButton])
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

