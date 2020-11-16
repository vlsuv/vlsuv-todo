//
//  SettingSectionHeaderView.swift
//  vlsuv-todo
//
//  Created by vlsuv on 15.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class SettingSectionHeaderView: UIView {
    // MARK: - Properties
    static let settingSectionHeaderViewHeight: CGFloat = 50
    
    let sectionNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = Colors.mediumGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    // MARK: - Init
    init(sectionName: String) {
        super.init(frame: CGRect.zero)
        self.setupSectionNameLabel(sectionName: sectionName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setupSectionNameLabel(sectionName: String) {
        addSubview(sectionNameLabel)
        sectionNameLabel.anchor(left: leftAnchor, right: rightAnchor, bottom: bottomAnchor, paddingLeft: 18, paddingRight: 18, paddingBottom: 11)
        
        sectionNameLabel.text = sectionName
    }
}
