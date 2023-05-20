//
//  QuotePost.swift
//  QuoteClub
//
//  Created by Baher Tamer on 10/05/2023.
//

import Kingfisher
import SwiftUI

struct QuotePost: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var quotePostViewModel: QuotePostViewModel
    
    var date: String {
        let dateComponent = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month], from: quotePostViewModel.quote.timestamp.dateValue(), to: Date.now)
        
        if dateComponent.month ?? 0 <= 12 && dateComponent.month ?? 0 != 0 {
            return "\(dateComponent.month ?? 0) month"
        } else if dateComponent.day ?? 0 < 30 && dateComponent.day ?? 0 != 0 {
            return "\(dateComponent.day ?? 0) day"
        } else if dateComponent.hour ?? 0 < 24 && dateComponent.hour ?? 0 != 0 {
            return "\(dateComponent.hour ?? 0) hr"
        } else if dateComponent.minute ?? 0 < 60 && dateComponent.minute ?? 0 != 0 {
            return "\(dateComponent.minute ?? 0) min"
        } else {
            return "\(dateComponent.second ?? 0) s"
        }
    }
    
    init(quote: Quote) {
        self.quotePostViewModel = QuotePostViewModel(quote: quote)
    }
    
    private var postButtons: some View {
        HStack {
            PostButton(quote: $quotePostViewModel.quote, buttonType: .like) {
                quotePostViewModel.quote.didLike ?? false ?
                quotePostViewModel.unlikeQuote() :
                quotePostViewModel.likeQuote()
            }
            
            Divider()
            
            PostButton(quote: $quotePostViewModel.quote,buttonType: .save) {
                quotePostViewModel.quote.didSave ?? false ?
                quotePostViewModel.unsaveQuote() :
                quotePostViewModel.saveQuote()
            }
        }
    }
    
    private var author: some View {
        HStack {
            Text("—")
            Text(quotePostViewModel.quote.author)
        }
        .foregroundColor(.secondary)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let user = quotePostViewModel.quote.user {
                    NavigationLink {
                        ProfileView(user: user)
                    } label: {
                        HStack {
                            KFImage(URL(string: user.profileImageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(user.fullName)
                                    .foregroundColor(.primary)
                                    .font(.headline)
                                
                                HStack {
                                    Text("@\(user.username)")
                                    Text("•")
                                    Text(date)

                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                
                Spacer()
                
                Menu {
                    if !(quotePostViewModel.quote.user?.isCurrentUser ?? false) {
                        Button(role: .destructive) {
                            // TODO: Report User
                        } label: {
                            Label("Report", systemImage: "exclamationmark.bubble")
                        }
                    } else {
                        Button(role: .destructive) {
                            quotePostViewModel.deleteQuote()
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .contentShape(Rectangle())
            }
            
            VStack(alignment: .leading) {
                Text(quotePostViewModel.quote.quote)
                    .padding(.vertical, 8)
                
                HStack {
                    author
                    
                    Spacer()
                    
                    if let category = QuoteCategory(rawValue: quotePostViewModel.quote.category) {
                        PostCategory(category: category)
                    }
                    
                }
            }
            
            Divider().padding(.vertical, 8)
            
            postButtons
        }
        .padding()
        .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

import Firebase

struct QuotePost_Previews: PreviewProvider {
    static var previews: some View {
        QuotePost(quote: Quote(quote: "One more thing", author: "Steve Jobs", category: "leadership", uid: "", timestamp: Timestamp(date: Date()), likes: 0, saves: 0))
            .previewLayout(.sizeThatFits)
    }
}
