//
//  ListCell.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = "ListCell"
    
    let listImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let listTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = Colors.black
        return label
    }()
    
    func configure(list: List) {
        listImage.image = list.image.getImage
        listTitle.text = list.title
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupListImage()
        setupListTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Handlers
    private func setupListImage() {
        self.addSubview(listImage)
        listImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        listImage.anchor(left: self.leftAnchor, paddingLeft: 18, height: 18, width: 18)
    }
    
    private func setupListTitle() {
        self.addSubview(listTitle)
        listTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        listTitle.anchor(left: listImage.rightAnchor, right: self.rightAnchor, paddingLeft: 18, paddingRight: 18)
    }
}
