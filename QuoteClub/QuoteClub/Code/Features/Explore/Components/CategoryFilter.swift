//
//  CategoryFilter.swift
//  QuoteClub
//
//  Created by Baher Tamer on 17/05/2023.
//

import SwiftUI

struct CategoryFilter: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentFilter: CategoryExploreFilter
    
    var action: (CategoryExploreFilter) -> Void
    
    @Namespace var animation
    
    init(filter: CategoryExploreFilter, action: @escaping (CategoryExploreFilter) -> Void) {
        self._currentFilter = State(initialValue: filter)
        self.action = action
    }
    
    var body: some View {
        HStack {
            ForEach(CategoryExploreFilter.allCases, id: \.rawValue) { filter in
                Button {
                    withAnimation(.spring()){
                        currentFilter = filter
                        action(filter)
                    }
                } label: {
                    Text(filter.rawValue.capitalized)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .font(currentFilter == filter ? .headline : .body)
                        .foregroundColor(currentFilter == filter ? .white : .gray)
                        .frame(maxWidth: .infinity)
                        .background {
                            ZStack {
                                if currentFilter == filter {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
                                        .matchedGeometryEffect(id: "CategoryFilter", in: animation)
                                }
                            }
                        }
                }
            }
        }
        .padding()
        .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

struct CategoryFilter_Previews: PreviewProvider {
    static var previews: some View {
        CategoryFilter(filter: .hot, action: { _ in })
    }
}
