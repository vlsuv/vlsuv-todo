//
//  List.swift
//  vlsuv-todo
//
//  Created by vlsuv on 10.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift

protocol List {
    var id: String? {get set}
    var title: String {get set}
    var type: ListType {get set}
    var image: ListImage {get set}
}

struct UserList: List, Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var type: ListType = .user
    var image: ListImage = .file
    var createdDate: Date?

    init(title: String, createdDate: Date?) {
        self.title = title
        self.createdDate = createdDate
    }
}

struct SmartList: List, Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var title: String
    var type: ListType
    var image: ListImage
    var isShow: Bool = true
    
    init(title: String, type: ListType, image: ListImage) {
        self.title = title
        self.type = type
        self.image = image
    }
    
    static func get() -> [SmartList] {
        return [
            SmartList(title: "All", type: .all, image: .folder),
            SmartList(title: "Important", type: .important, image: .star),
            SmartList(title: "Completed", type: .completed, image: .check)
        ]
    }
}
