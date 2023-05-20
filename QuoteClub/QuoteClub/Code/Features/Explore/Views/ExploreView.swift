//
//  ExploreView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 11/05/2023.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var exploreViewModel = ExploreViewModel()
    
    private var columnGrid = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columnGrid) {
                    if exploreViewModel.searchQuery.isEmpty {
                        ForEach(QuoteCategory.allCases, id: \.rawValue) { category in
                            NavigationLink {
                                CategoryView(category: category)
                            } label: {
                                QuoteCategoryCard(category: category)
                            }

                        }
                    } else {
                        ForEach(exploreViewModel.filteredUsers, id: \.id) { user in
                            NavigationLink {
                                ProfileView(user: user)
                            } label: {
                                ProfileSearchCard(user: user)
                            }
                        }
                    }
                }
                .padding([.top, .horizontal])
                .padding(.bottom, 80)
            }
            .modifier(CustomNavigationBar(title: "Explore"))
        }
        .searchable(text: $exploreViewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for users")
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ExploreView()
                .navigationTitle("Explore")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
