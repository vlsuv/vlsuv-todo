//
//  AccountInfoTableViewHeader.swift
//  vlsuv-todo
//
//  Created by vlsuv on 13.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

protocol AccountInfoViewDelegate: class {
    func didTapEditAccount()
}

class AccountInfoView: UIView {
    // MARK: - Properties
    weak var delegate: AccountInfoViewDelegate!
    
    static let accountInfoViewHeight: CGFloat = 210
    private let userImageViewHeight: CGFloat = 70
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "userImage")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .light)
        label.textColor = Colors.black
        label.text = "vlsuv"
        return label
    }()
    
    let editAccountButton: UIButton = {
        let button = UIButton()
        let normalAttributedString = NSAttributedString(string: "Edit Account", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium),
            NSAttributedString.Key.foregroundColor: Colors.baseBlue
            ])
        button.setAttributedTitle(normalAttributedString, for: .normal)
        button.contentVerticalAlignment = .center
        button.addTopBorder(color: Colors.lightGray)
        
        button.addTarget(self, action: #selector(handleEditAccount), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.white
        
        setupUserImageView()
        setupUserNameLabel()
        setupEditAccountButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func handleEditAccount() {
        delegate.didTapEditAccount()
    }
    
    // MARK: - Handlers
    private func setupUserImageView() {
        addSubview(userImageView)
        userImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userImageView.anchor(top: topAnchor, paddingTop: 30, height: userImageViewHeight, width: userImageViewHeight)
        userImageView.layer.cornerRadius = userImageViewHeight/2
    }
    
    private func setupUserNameLabel() {
        addSubview(userNameLabel)
        userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        userNameLabel.anchor(top: userImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
    }
    
    private func setupEditAccountButton() {
        addSubview(editAccountButton)
        editAccountButton.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, height: 44)
    }
}
