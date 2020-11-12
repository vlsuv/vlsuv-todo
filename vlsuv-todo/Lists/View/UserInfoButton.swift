//
//  UserInfoButton.swift
//  vlsuv-todo
//
//  Created by vlsuv on 11.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class UserInfoButton: UIButton {
    // MARK: - Properties
    private let userImageHeight: CGFloat = 30
    
    private var userName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = Colors.black
        return label
    }()
    
    private var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    func configureUser() {
        userName.text = "vlsuv"
        userImage.image = UIImage(named: "userImage")
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserImageView()
        setupUserNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setupUserImageView() {
        addSubview(userImage)
        userImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userImage.anchor(left: leftAnchor, paddingLeft: -8, height: userImageHeight, width: userImageHeight)
        userImage.layer.cornerRadius = userImageHeight/2
    }
    
    private func setupUserNameLabel() {
        addSubview(userName)
        userName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        userName.anchor(left: userImage.rightAnchor, right: rightAnchor, paddingLeft: 18)
    }
}
