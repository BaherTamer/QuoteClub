//
//  AuthViewModel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 14/05/2023.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    private let userService = UserService()
    
    init() {
        self.userSession =  Auth.auth().currentUser
        self.fetchUser()
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchUser(uid: uid) { user in
            self.currentUser = user
        }
    }
    
    func login(withUser user: UserInputData) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error {
                print("DEBUG: Failed to login, \(error)")
                return
            }
            
            guard let loggedInUser = result?.user else { return }
            
            self.userSession = loggedInUser
            self.fetchUser()
            
            print("DEBUG: Logged in successfully, \(String(describing: self.userSession?.uid)).")
        }
    }
    
    func register(withUser user: UserInputData, profileImage: UIImage?) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { result, error in
            if let error {
                print("DEBUG: Failed to create user, \(error)")
                return
            }
            
            guard let registeredUser = result?.user else { return }
            
            self.userSession = registeredUser
            print("DEBUG: Registered successfully, \(String(describing: self.userSession?.uid)).")
            
            guard let profileImage else {
                print("DEBUG: User profile image is not found!")
                return
            }
            
            ImageUploader.uploadImage(image: profileImage) { userImageURL in
                let userData = [
                    "email": user.email,
                    "username": user.username.lowercased(),
                    "fullName": user.fullName,
                    "favoriteQuote": "",
                    "profileImageURL": userImageURL
                ]
                
                Firestore.firestore().collection("users").document(registeredUser.uid).setData(userData) { _ in
                    print("DEBUG: User data uploaded successfully, \(userData).")
                }
                
                self.fetchUser()
            }
        }
    }
    
    func signOut() {
        self.userSession = nil
        self.currentUser = nil
        try? Auth.auth().signOut()
    }
}
