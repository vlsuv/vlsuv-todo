//
//  BottomMenu.swift
//  vlsuv-todo
//
//  Created by vlsuv on 11.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

protocol BottomMenuViewDelegate {
    func didTapCreateList()
}

class BottomMenuView: UIView {
    // MARK: - Properties
    var delegate: BottomMenuViewDelegate!
    let bottomMenuViewHeight: CGFloat = 44
    
    private let createListButton: UIButton = {
        let button = UIButton()
        let addListNormalAttributedString = NSAttributedString(string: "New List", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium),
            NSAttributedString.Key.foregroundColor: Colors.baseBlue
            ])
        button.setAttributedTitle(addListNormalAttributedString, for: .normal)
        button.setImage(Images.plus, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets.left = 18
        button.addTarget(self, action: #selector(handleCreateList), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Actions
    @objc private func handleCreateList() {
        delegate.didTapCreateList()
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCreateListButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setupCreateListButton() {
        addSubview(createListButton)
        createListButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        createListButton.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingLeft: 18, width: 134)
    }
}
