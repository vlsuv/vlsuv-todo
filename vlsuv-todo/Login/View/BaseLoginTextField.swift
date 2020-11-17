//
//  BaseLoginTextField.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class BaseLoginTextField: UITextField {
    // MARK: - Properties
    private let baseLoginTextFieldHeight: CGFloat = 53
    
    let title: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = Colors.mediumGray
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Init
    init(name: String, secureText: Bool = false) {
        super.init(frame: CGRect.zero)
        configure(secureText: secureText)
        addTitle(text: name)
        addBottomBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: baseLoginTextFieldHeight)
    }
    
    // MARK: - Handlers
    private func configure(secureText: Bool) {
        self.font = .systemFont(ofSize: 18, weight: .regular)
        self.textColor = Colors.black
        
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.isSecureTextEntry = secureText
    }
    
    private func addTitle(text: String) {
        title.text = text
        
        self.addSubview(title)
        title.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, paddingTop: -10)
    }
    
    private func addBottomBorder() {
        self.borderStyle = .none
        
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = Colors.lightGray
        self.addSubview(bottomBorder)
        bottomBorder.anchor(left: self.leftAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, height: 1)
    }
}
