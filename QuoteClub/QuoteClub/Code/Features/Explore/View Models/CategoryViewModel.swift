//
//  CategoryViewModel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 17/05/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    
    let category: QuoteCategory
    let quoteService = QuoteService()
    let userService = UserService()
    
    @Published var quotes: [Quote] = []
    @Published var filter: CategoryExploreFilter
    
    init(category: QuoteCategory) {
        self.category = category
        self.filter = .hot
        
        fetchQuotesWithCategory()
        sortQuotes()
    }
    
    func fetchQuotesWithCategory() {
        self.quoteService.fetchQuotes(byCategory: self.category) { fetchedQuotes in
            self.quotes = fetchedQuotes
            
            for index in 0 ..< fetchedQuotes.count {
                let uid = fetchedQuotes[index].uid
                
                self.userService.fetchUser(uid: uid) { user in
                    self.quotes[index].user = user
                }
            }
        }
    }
    
    func sortQuotes() {
        self.quotes = self.quotes.sorted {
            switch self.filter {
            case .hot:
                return $0.likes > $1.likes
            case .new:
                return $0.timestamp.dateValue() > $1.timestamp.dateValue()
            }
        }
    }
}
