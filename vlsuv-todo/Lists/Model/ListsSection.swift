//
//  ListsControllerSection.swift
//  vlsuv-todo
//
//  Created by vlsuv on 22.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation

enum ListSection: Int, CaseIterable, CustomStringConvertible {
    case smartLists
    case userLists
    
    var description: String {
        switch self {
        case .smartLists:
            return "SMART LISTS"
        case .userLists:
            return "USER LISTS"
        }
    }
    
    var isEdit: Bool {
        switch self {
        case .smartLists:
            return false
        case .userLists:
            return true
        }
    }
    
    var footerViewIsShow: Bool {
        switch self {
        case .smartLists:
            return true
        case .userLists:
            return false
        }
    }
}
