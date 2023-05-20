//
//  ProfileSearchCard.swift
//  QuoteClub
//
//  Created by Baher Tamer on 15/05/2023.
//

import Kingfisher
import SwiftUI

struct ProfileSearchCard: View {
    
    let user: User
    
    var body: some View {
        VStack {
            KFImage(URL(string: user.profileImageURL))
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            Text(user.fullName)
                .font(.headline)
                .foregroundColor(.primary)
        
            Text("@\(user.username)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.bottom)
    }
}

struct ProfileSearchCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSearchCard(user: User(email: "baher@email.com", username: "bahertamer", profileImageURL: "https://developer.apple.com/swift/images/swift-og.png", fullName: "Baher Tamer", favoriteQuote: "One more thing"))
    }
}
