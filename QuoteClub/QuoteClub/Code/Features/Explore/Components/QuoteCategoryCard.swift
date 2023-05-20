//
//  QuoteCategoryCard.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct QuoteCategoryCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let category: QuoteCategory
    
    private var categoryIcon: some View {
        Text(category.icon)
            .padding(24)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
            .cornerRadius(20)
        
    }
    
    private var categoryTitle: some View {
        Text(category.rawValue.capitalized)
            .foregroundColor(.primary)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 4)
    }
    
    var body: some View {
        VStack {
            categoryIcon
            categoryTitle
        }
        .padding(.bottom)
    }
}

struct QuoteCategoryCard_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCategoryCard(category: .affirmations)
    }
}
