//
//  QuoteService.swift
//  QuoteClub
//
//  Created by Baher Tamer on 16/05/2023.
//

import Firebase

struct QuoteService {
    
    func uploadQuote(quote: String, author: String, category: QuoteCategory) {
        guard let uid = getCurrentUserID() else { return }
        
        let data = [
            "uid": uid,
            "quote": quote,
            "author": author,
            "category": category.rawValue.lowercased(),
            "likes": 0,
            "saves": 0,
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        Firestore.firestore().collection("quotes").document()
            .setData(data) { error in
                if let error {
                    print("DEBUG: Failed th upload quote, \(error)")
                    return
                }
                
                print("DEBUG: Quote uploaded successfully, \(data)")
            }
    }
    
    func deleteQuote(quote: Quote, complettion: @escaping (String?) -> Void) {
        guard let quoteID = quote.id else { return }
        
        Firestore.firestore().collection("quotes").document(quoteID)
            .delete { _ in
                complettion(quoteID)
            }
    }
    
    func deleteDeletedQuote(fromUsers users: [User], quoteID: String) {
        let usersCollection = Firestore.firestore().collection("users")
        
        for user in users {
            guard let userID = user.id else { continue }
            
            usersCollection.document(userID).collection("userLikes").document(quoteID).delete()
            usersCollection.document(userID).collection("userSaves").document(quoteID).delete()
        }
    }
}

// MARK: - Fetch Logic
extension QuoteService {
    func fetchQuotes(complettion: @escaping ([Quote]) -> Void) {
        Firestore.firestore().collection("quotes")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: Failed to download quotes data, \(String(describing: error))")
                    return
                }
                
                let quotes = documents.compactMap {
                    try? $0.data(as: Quote.self)
                }
                
                complettion(quotes)
            }
    }
    
    func fetchQuotes(forUserWithID uid: String, complettion: @escaping ([Quote]) -> Void) {
        Firestore.firestore().collection("quotes")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: Failed to download quotes data for user id: \(uid), \(String(describing: error))")
                    return
                }
                
                let quotes = documents.compactMap {
                    try? $0.data(as: Quote.self)
                }
                
                complettion(quotes.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
            }
    }
    
    func fetchQuotes(byCategory category: QuoteCategory, complettion: @escaping ([Quote]) -> Void) {
        Firestore.firestore().collection("quotes")
            .whereField("category", isEqualTo: category.rawValue.lowercased())
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: Failed to download quotes data for category: \(category), \(String(describing: error))")
                    return
                }
                
                let quotes = documents.compactMap {
                    try? $0.data(as: Quote.self)
                }
                
                complettion(quotes)
            }
    }
    
    func fetchLikedQuotes(forUserWithID uid: String, complettion: @escaping ([Quote]) -> Void) {
        var quotes: [Quote] = []
        
        Firestore.firestore().collection("users").document(uid).collection("userLikes")
            .getDocuments { documentSnapshot, _ in
                guard let documents = documentSnapshot?.documents else { return }
                
                documents.forEach { document in
                    let quoteID = document.documentID
                    
                    Firestore.firestore().collection("quotes").document(quoteID)
                        .getDocument { quoteSnapshot, _ in
                            guard let quote = try? quoteSnapshot?.data(as: Quote.self) else { return }
                            
                            quotes.append(quote)
                            complettion(quotes.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                        }
                }
            }
    }
    
    func fetchSavedQuotes(forUserWithID uid: String, complettion: @escaping ([Quote]) -> Void) {
        var quotes: [Quote] = []
        
        Firestore.firestore().collection("users").document(uid).collection("userSaves")
            .getDocuments { documentSnapshot, _ in
                guard let documents = documentSnapshot?.documents else { return }
                
                documents.forEach { document in
                    let quoteID = document.documentID
                    
                    Firestore.firestore().collection("quotes").document(quoteID)
                        .getDocument { quoteSnapshot, _ in
                            guard let quote = try? quoteSnapshot?.data(as: Quote.self) else { return }
                            
                            quotes.append(quote)
                            complettion(quotes.sorted(by: { $0.timestamp.dateValue() > $1.timestamp.dateValue() }))
                        }
                }
            }
    }
}

// MARK: - Like Logic
extension QuoteService {
    func likeQuote(_ quote: Quote, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        
        let userLikesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userLikes")
        
        Firestore.firestore().collection("quotes").document(quoteID)
            .updateData(["likes": quote.likes + 1]) { error in
                if let error {
                    print("DEBUG: Failed to update quote likes, \(error)")
                    return
                }
                
                userLikesCollectionRef.document(quoteID).setData([:]) { _ in
                    completion(quote.likes + 1)
                }
            }
    }
    
    func unlikeQuote(_ quote: Quote, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        guard quote.likes > 0 else { return }
        
        let userLikesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userLikes")
        
        Firestore.firestore().collection("quotes").document(quoteID)
            .updateData(["likes": quote.likes - 1]) { error in
                if let error {
                    print("DEBUG: Failed to update quote likes, \(error)")
                    return
                }
                
                userLikesCollectionRef.document(quoteID).delete { _ in
                    completion(quote.likes - 1)
                }
            }
    }
    
    func didUserLikedQuote(_ quote: Quote, completion: @escaping (Bool) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("userLikes").document(quoteID)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                completion(snapshot.exists)
            }
    }
}

// MARK: - Save Logic
extension QuoteService {
    func saveQuote(_ quote: Quote, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        
        let userSavesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userSaves")
        
        Firestore.firestore().collection("quotes").document(quoteID)
            .updateData(["saves": quote.saves + 1]) { error in
                if let error {
                    print("DEBUG: Failed to update quote saves, \(error)")
                    return
                }
                
                userSavesCollectionRef.document(quoteID).setData([:]) { _ in
                    completion(quote.saves + 1)
                }
            }
    }
    
    func unsaveQuote(_ quote: Quote, completion: @escaping (Int) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        guard quote.saves > 0 else { return }
        
        let userSavesCollectionRef = Firestore.firestore().collection("users").document(uid).collection("userSaves")
        
        Firestore.firestore().collection("quotes").document(quoteID)
            .updateData(["saves": quote.saves - 1]) { error in
                if let error {
                    print("DEBUG: Failed to update quote saves, \(error)")
                    return
                }
                
                userSavesCollectionRef.document(quoteID).delete { _ in
                    completion(quote.saves - 1)
                }
            }
    }
    
    func didUserSavedQuote(_ quote: Quote, completion: @escaping (Bool) -> Void) {
        guard let uid = getCurrentUserID() else { return }
        guard let quoteID = quote.id else { return }
        
        Firestore.firestore().collection("users").document(uid).collection("userSaves").document(quoteID)
            .getDocument { snapshot, _ in
                guard let snapshot else { return }
                completion(snapshot.exists)
            }
    }
}

// MARK: - Helpers
extension QuoteService {
    
    private func getCurrentUserID() -> String? {
        Auth.auth().currentUser?.uid
    }
    
}
