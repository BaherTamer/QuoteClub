//
//  CategoryView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 17/05/2023.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject var categoryViewModel: CategoryViewModel
    
    init(category: QuoteCategory) {
        self.categoryViewModel = CategoryViewModel(category: category)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                CategoryFilter(filter: categoryViewModel.filter) { newFilter in
                    categoryViewModel.filter = newFilter
                    categoryViewModel.sortQuotes()
                }
                
                VStack {
                    ForEach(categoryViewModel.quotes) { quote in
                        QuotePost(quote: quote)
                    }
                }
                .padding(.bottom, 80)
            }
        }
        .onAppear(perform: {
            self.categoryViewModel.sortQuotes()
        })
        .modifier(CustomNavigationBar(title: "\(categoryViewModel.category.icon) \(categoryViewModel.category.rawValue.capitalized)"))
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryView(category: .affirmations)
        }
    }
}
