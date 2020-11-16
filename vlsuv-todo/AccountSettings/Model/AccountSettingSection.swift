//
//  AccountSettingsViewModelType.swift
//  vlsuv-todo
//
//  Created by vlsuv on 12.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit

enum AccountSettingSection: Int, CaseIterable, CustomStringConvertible {
    case smartLists
    
    var description: String {
        switch self {
        case .smartLists:
            return "SMART LISTS"
        }
    }
}
