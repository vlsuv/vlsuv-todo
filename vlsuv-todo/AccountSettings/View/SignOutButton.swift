//
//  SignOutButton.swift
//  vlsuv-todo
//
//  Created by vlsuv on 15.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

protocol SignOutButtonDelegate: class {
    func didTapSignOut()
}

class SignOutButton: UIButton {
    // MARK: - Properties
    weak var delegate: SignOutButtonDelegate!
    static let signOutButtonHeight: CGFloat = 44
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Action
    @objc private func handleSignOut() {
        delegate.didTapSignOut()
    }
    
    // MARK: - Handlers
    private func configure() {
        let normalAttributedString = NSAttributedString(string: "Sign Out", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
            NSAttributedString.Key.foregroundColor: Colors.red
            ])
        setAttributedTitle(normalAttributedString, for: .normal)
        backgroundColor = .white
        
        addTarget(self, action: #selector(handleSignOut), for: .touchUpInside)
    }
}
