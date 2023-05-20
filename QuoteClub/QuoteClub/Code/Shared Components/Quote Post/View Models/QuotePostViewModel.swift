//
//  QuotePostViewModel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 17/05/2023.
//

import Foundation

class QuotePostViewModel: ObservableObject {
    
    @Published var quote: Quote
    
    let quoteService = QuoteService()
    let userService = UserService()
    
    init(quote: Quote) {
        self.quote = quote
        fetchQuoteStates()
    }
    
    func likeQuote() {
        self.quoteService.likeQuote(quote) { likes in
            self.quote.didLike = true
            self.quote.likes = likes
        }
    }
    
    func unlikeQuote() {
        self.quoteService.unlikeQuote(quote) { likes in
            self.quote.didLike = false
            self.quote.likes = likes
        }
    }
    
    func saveQuote() {
        self.quoteService.saveQuote(quote) { saves in
            self.quote.didSave = true
            self.quote.saves = saves
        }
    }
    
    func unsaveQuote() {
        self.quoteService.unsaveQuote(quote) { saves in
            self.quote.didSave = false
            self.quote.saves = saves
        }
    }
    
    func fetchQuoteStates() {
        quoteService.didUserLikedQuote(self.quote) { didLiked in
            if didLiked {
                self.quote.didLike = true
            }
        }
        
        quoteService.didUserSavedQuote(self.quote) { didSaved in
            if didSaved {
                self.quote.didSave = true
            }
        }
    }
    
    func deleteQuote() {
        if ((self.quote.user?.isCurrentUser) != nil) {
            quoteService.deleteQuote(quote: self.quote) { quoteID in
                if let quoteID {
                    self.userService.fetchUsers { users in
                        self.quoteService.deleteDeletedQuote(fromUsers: users, quoteID: quoteID)
                    }
                }
            }
        }
    }
}
