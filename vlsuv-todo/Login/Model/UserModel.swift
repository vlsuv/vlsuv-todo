//
//  User.swift
//  vlsuv-todo
//
//  Created by vlsuv on 16.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation
import Firebase

struct UserModel {
    let uid: String
    let email: String
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
    func convertToDictionary() -> [String: Any] {
        return [
            "uid": uid,
            "email": email
        ]
    }
}
