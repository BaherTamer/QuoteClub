//
//  ExploreViewModel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 15/05/2023.
//

import Foundation

class ExploreViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var searchQuery: String = ""
    
    let userService = UserService()
    
    var filteredUsers: [User] {
        if searchQuery.isEmpty {
            return users
        } else {
            return users.filter {
                $0.username.contains(searchQuery.lowercased()) || $0.fullName.lowercased().contains(searchQuery.lowercased())
            }
        }
    }
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        self.userService.fetchUsers { fetchedUsers in
            self.users = fetchedUsers
        }
    }
    
}
