//
//  ListType.swift
//  vlsuv-todo
//
//  Created by vlsuv on 24.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation

enum ListType {
    case all
    case important
    case completed
    case user
}

extension ListType: Codable {
    enum CodingKeys: CodingKey {
        case rawValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0: self = .all
        case 1: self = .important
        case 2: self = .completed
        case 3: self = .user
        default:
            throw CodingError.unknownValue
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .all:
            try container.encode(0, forKey: .rawValue)
        case .important:
            try container.encode(1, forKey: .rawValue)
        case .completed:
            try container.encode(2, forKey: .rawValue)
        case .user:
            try container.encode(3, forKey: .rawValue)
        }
    }
}
