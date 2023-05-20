//
//  ProfileFilter.swift
//  QuoteClub
//
//  Created by Baher Tamer on 11/05/2023.
//

import SwiftUI

struct ProfileFilter: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentFilter: PostsFilter = .quotes
    
    @Namespace var animation
    
    var action: (PostsFilter) -> Void
    
    var body: some View {
        HStack {
            ForEach(PostsFilter.allCases, id: \.rawValue) { filter in
                Button {
                    withAnimation(.spring()){
                        currentFilter = filter
                        action(currentFilter)
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
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
                                        .matchedGeometryEffect(id: "PostFilter", in: animation)
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

struct ProfileFilter_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFilter(action: { _ in })
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemGray6), ignoresSafeAreaEdges: .all)
    }
}
