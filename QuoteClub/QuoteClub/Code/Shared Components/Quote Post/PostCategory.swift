//
//  PostCategory.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct PostCategory: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    @Environment(\.colorScheme) var colorScheme
    
    let category: QuoteCategory
    
    var color: Color {
        (AppColor(rawValue: appColor.lowercased())?.color ?? .indigo).opacity(colorScheme == .light ? 0.1 : 0.2)
    }
    
    var body: some View {
        NavigationLink {
            CategoryView(category: category)
        } label: {
            HStack {
                Text(category.icon)
                Text(category.rawValue.capitalized)
                    .shadow(color: .primary, radius: 0.1)
            }
            .font(.footnote)
            .fontWeight(.semibold)
            .padding(8)
            .foregroundColor(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
            .background(color)
            .cornerRadius(8)
        }

    }
}

struct PostCategory_Previews: PreviewProvider {
    static var previews: some View {
        PostCategory(category: .affirmations)
    }
}
