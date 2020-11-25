//
//  ListManager.swift
//  vlsuv-todo
//
//  Created by vlsuv on 18.11.2020.
//  Copyright © 2020 vlsuv. All rights reserved.
//

import Foundation
import Firebase

class ListManager {
    
    private let db = Firestore.firestore()
    static let shared = ListManager()
    
    private init() {}
    
    func fetchSmartLists(withUserUid userUid: String, completion: @escaping ([SmartList]) -> ()) {
        
        db
            .collection(FirebaseKeys.CollectionPath.users)
            .document(userUid)
            .collection(FirebaseKeys.CollectionPath.smartLists)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else {return}
                
                var smartLists = [SmartList]()
                for document in documents {
                    do {
                        let smartList = try document.data(as: SmartList.self)
                        smartLists.append(smartList!)
                    }catch {
                        print(error.localizedDescription)
                    }
                    completion(smartLists)
                }
        }
    }
    
    func fetchUserLists(withUserUid userUid: String, completion: @escaping ([UserList]) -> ()) {
        
        db
            .collection(FirebaseKeys.CollectionPath.users)
            .document(userUid)
            .collection(FirebaseKeys.CollectionPath.userLists)
            .order(by: "createdDate")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let documents = snapshot?.documents else {return}
                
                var userLists = [UserList]()
                for document in documents {
                    do {
                        let userList = try document.data(as: UserList.self)
                        userLists.append(userList!)
                    } catch {
                        print(error.localizedDescription)
                    }
                    completion(userLists)
                }
        }
    }
    
    func add(withUserUid userUid: String, usingList list: UserList) {
        
        do {
            let _ = try db.collection(FirebaseKeys.CollectionPath.users).document(userUid).collection(FirebaseKeys.CollectionPath.userLists).addDocument(from: list)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func delete(withUserUid userUid: String, usingList list: List) {
        
        db
            .collection(FirebaseKeys.CollectionPath.users)
            .document(userUid)
            .collection(FirebaseKeys.CollectionPath.userLists)
            .document(list.id!)
            .getDocument { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let snapshotRef = snapshot?.reference else {return}
                
                snapshotRef.delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
        }
    }
    
    func updateSmartList(withUserUid userUid: String, usingList list: SmartList) {
        
        do {
            try db
            .collection(FirebaseKeys.CollectionPath.users)
            .document(userUid)
            .collection(FirebaseKeys.CollectionPath.smartLists)
            .document(list.id!)
                .setData(from: list)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func addSmartLists(withUserUid userUid: String, completion: @escaping (Error?) -> ()) {
        
        let smartLists = [
            SmartList(title: "All", type: .all, image: .folder),
            SmartList(title: "Important", type: .important, image: .star),
            SmartList(title: "Completed", type: .completed, image: .check)
        ]
        
        smartLists.forEach { smartList in
            do {
                let _ = try db
                    .collection(FirebaseKeys.CollectionPath.users)
                    .document(userUid)
                    .collection(FirebaseKeys.CollectionPath.smartLists)
                    .addDocument(from: smartList)
            }catch {
                completion(error)
            }
        }
    }
}
