//
//  UserDataModel.swift
//  vlsuv-todo
//
//  Created by vlsuv on 16.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation
import Firebase

class UserManager {
    
    private init() {}
    
    static func createUser(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            print("create user: " + result!.user.email!)
            completion(nil)
        }
    }
    
    static func signIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
        }
    }
}
