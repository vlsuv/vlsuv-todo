//
//  ListImage.swift
//  vlsuv-todo
//
//  Created by vlsuv on 24.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

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

extension ListImage: Codable {
    enum CodingKeys: CodingKey {
        case rawWalue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawWalue)
        switch rawValue {
        case 0: self = .file
        case 1: self = .star
        case 2: self = .check
        case 3: self = .folder
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .file:
            try container.encode(0, forKey: .rawWalue)
        case .star:
            try container.encode(1, forKey: .rawWalue)
        case .check:
            try container.encode(2, forKey: .rawWalue)
        case .folder:
            try container.encode(3, forKey: .rawWalue)
        }
    }
}
