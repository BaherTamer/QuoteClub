//
//  Quote.swift
//  QuoteClub
//
//  Created by Baher Tamer on 16/05/2023.
//

import Firebase
import FirebaseFirestoreSwift

struct Quote: Identifiable, Decodable {
    
    @DocumentID var id: String?
    
    let quote: String
    let author: String
    let category: String
    let uid: String
    let timestamp: Timestamp
    
    var likes: Int
    var saves: Int
    var user: User?
    var didLike: Bool? = false
    var didSave: Bool? = false
}
