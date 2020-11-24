//
//  ListsControllerSection.swift
//  vlsuv-todo
//
//  Created by vlsuv on 22.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation

enum SectionName {
    case smartLists
    case userLists
}

struct ListsSection {
    let name: SectionName
    var lists: [List]
    let isEdit: Bool
    let footerViewIsShow: Bool
    
    init(name: SectionName, lists: [List], isEdit: Bool, footerViewIsShow: Bool) {
        self.name = name
        self.lists = lists
        self.isEdit = isEdit
        self.footerViewIsShow = footerViewIsShow
    }
    
    static func getSections() -> [ListsSection] {
        [ListsSection(name: .smartLists, lists: [SmartList](), isEdit: false, footerViewIsShow: true),
         ListsSection(name: .userLists, lists: [UserList](), isEdit: true, footerViewIsShow: false)]
    }
}
