//
//  UserService.swift
//  QuoteClub
//
//  Created by Baher Tamer on 15/05/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(uid: String, complettion: @escaping (User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot else {
                    print("DEBUG: Failed to download user data.")
                    return
                }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                complettion(user)
            }
    }
    
    func fetchUsers(complettion: @escaping ([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: Failed to download users data.")
                    return
                }
                
                let users = documents.compactMap {
                    try? $0.data(as: User.self)
                }
                
                complettion(users)
            }
    }
    
    func editUserFullName(uid: String, newName: String, complettion: @escaping (Bool) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["fullName": newName]) { error in
                if let error {
                    print("DEBUG: Failed to update user full name, \(error)")
                    complettion(false)
                }
                
                complettion(true)
            }
    }
    
    func editUserFavoriteQuote(uid: String, newQuote: String, complettion: @escaping (Bool) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .updateData(["favoriteQuote": newQuote]) { error in
                if let error {
                    print("DEBUG: Failed to update user favorite quote, \(error)")
                    complettion(false)
                }
                
                complettion(true)
            }
    }
}
