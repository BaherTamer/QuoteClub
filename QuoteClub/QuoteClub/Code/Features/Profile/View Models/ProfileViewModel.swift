//
//  ProfileViewModel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 16/05/2023.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    @Published var quotes: [Quote] = []
    @Published private var writtenQuotes: [Quote] = []
    @Published private var likedQuotes: [Quote] = []
    @Published private var savedQuotes: [Quote] = []
    
    private let quoteService = QuoteService()
    private let userService = UserService()
    
    init(user: User) {
        self.user = user
        
        fetchUserQuotes()
        fetchLikedQuotes()
        fetchSavedQuotes()
    }
    
    func fetchUserQuotes() {
        guard let uid = self.user.id else { return }
        
        quoteService.fetchQuotes(forUserWithID: uid) { quotes in
            self.writtenQuotes = quotes
            
            for index in 0 ..< quotes.count {
                self.writtenQuotes[index].user = self.user
            }
            
            self.quotes = self.writtenQuotes
        }
    }
    
    func fetchLikedQuotes() {
        guard let uid = self.user.id else { return }
        
        quoteService.fetchLikedQuotes(forUserWithID: uid) { quotes in
            self.likedQuotes = quotes
            
            for index in 0 ..< quotes.count {
                let userID = quotes[index].uid
                
                self.userService.fetchUser(uid: userID) { user in
                    self.likedQuotes[index].user = user
                }
            }
        }
    }
    
    func fetchSavedQuotes() {
        guard let uid = self.user.id else { return }
        
        quoteService.fetchSavedQuotes(forUserWithID: uid) { quotes in
            self.savedQuotes = quotes
            
            for index in 0 ..< quotes.count {
                let userID = quotes[index].uid
                
                self.userService.fetchUser(uid: userID) { user in
                    self.savedQuotes[index].user = user
                }
            }
        }
    }
    
    func filterQuotes(by filter: PostsFilter) {
        switch filter {
        case .quotes:
            self.quotes = writtenQuotes
        case .likes:
            self.quotes =  likedQuotes
        case .saved:
            self.quotes =  savedQuotes
        }
    }
    
    func updateFullName(newName: String) {
        if newName != self.user.fullName {
            userService.editUserFullName(uid: self.user.id ?? "", newName: newName) { result in
                if result {
                    self.userService.fetchUser(uid: self.user.id ?? "") { user in
                        self.user = user
                    }
                } else {
                    return
                }
            }
        }
    }
    
    func updateFavoriteQuote(newQuote: String) {
        if newQuote != self.user.favoriteQuote {
            userService.editUserFavoriteQuote(uid: self.user.id ?? "", newQuote: newQuote) { result in
                if result {
                    self.userService.fetchUser(uid: self.user.id ?? "") { user in
                        self.user = user
                    }
                } else {
                    return
                }
            }
        }
    }
}
