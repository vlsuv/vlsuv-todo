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
    
    static func currentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    static func createUser(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let result = result else {return}
            
            let newUser = UserModel(user: result.user)
            let db = Firestore.firestore()
            db.collection(FirebaseKeys.CollectionPath.users).document(newUser.uid).setData(newUser.convertToDictionary()) { error in
                if let error = error {
                    completion(error)
                    return
                }
            }
            
            ListManager.shared.addSmartLists(withUserUid: newUser.uid) { error in
                if let error = error {
                    completion(error)
                    return
                }
            }
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
