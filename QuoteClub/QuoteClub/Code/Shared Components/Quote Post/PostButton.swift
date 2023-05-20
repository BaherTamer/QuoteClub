//
//  PostButton.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct PostButton: View {
    
    @Binding var quote: Quote
    
    let buttonType: PostButtonType
    
    var action: () -> Void
    
    private var quoteState: Bool {
        switch self.buttonType {
        case .like:
            return quote.didLike ?? false
        case .save:
            return quote.didSave ?? false
        }
    }
    
    private var count: Int {
        switch self.buttonType {
        case .like:
            return quote.likes
        case .save:
            return quote.saves
        }
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: quoteState ? buttonType.iconFilled : buttonType.icon)
                
                Text("\(count)")
            }
            .frame(maxWidth: .infinity)
            .font(.headline)
            .tint(quoteState ? buttonType.color : .secondary)
        }
    }
}

import Firebase

struct PostButton_Previews: PreviewProvider {
    static var previews: some View {
        PostButton(quote: .constant(Quote(quote: "One more thing", author: "Steve Jobs", category: "leadership", uid: "", timestamp: Timestamp(date: Date()), likes: 0, saves: 0)), buttonType: .like, action: {})
    }
}
