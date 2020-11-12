//
//  List.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

struct List {
    let title: String
    let image: ListImage
    
    init(title: String, image: ListImage) {
        self.title = title
        self.image = image
    }
    
    enum ListImage {
        case file
        case star
        case check
        case folder
        
        var getImage: UIImage {
            switch self {
            case .file: return Images.file ?? UIImage()
            case .star: return Images.star ?? UIImage()
            case .check: return Images.check ?? UIImage()
            case .folder: return Images.folder ?? UIImage()
            }
        }
    }
}


