//
//  AccountSettingCell.swift
//  vlsuv-todo
//
//  Created by vlsuv on 12.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class SmartListSettingCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "AccountSettingCell"
    
    let smartListImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let smartListTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.textColor = Colors.black
        return label
    }()
    
    let smartListSwitchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = Colors.baseBlue
        return switchControl
    }()
    
    func configure(smartList: List) {
        self.smartListTitle.text = smartList.title
        self.smartListImage.image = smartList.image.getImage
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.white
        selectionStyle = .none
        
        setupSmartListImageView()
        setupSmartListTitleLabel()
        setupSmartListSwitchControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setupSmartListImageView() {
        addSubview(smartListImage)
        smartListImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        smartListImage.anchor(left: leftAnchor, paddingLeft: 18, height: 18, width: 18)
    }
    
    private func setupSmartListTitleLabel() {
        addSubview(smartListTitle)
        smartListTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        smartListTitle.anchor(left: smartListImage.rightAnchor, right: rightAnchor, paddingLeft: 18, paddingRight: 18)
    }
    
    private func setupSmartListSwitchControl() {
        addSubview(smartListSwitchControl)
        smartListSwitchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        smartListSwitchControl.anchor(right: rightAnchor, paddingRight: 18)
    }
}
