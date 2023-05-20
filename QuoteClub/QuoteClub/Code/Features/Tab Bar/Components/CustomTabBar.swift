//
//  CustomTabBar.swift
//  QuoteClub
//
//  Created by Baher Tamer on 10/05/2023.
//

import SwiftUI

struct CustomTabBar: View {
    
    var animation: Namespace.ID
    
    @Binding var currentTab: TabViewItem
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(.black.opacity(0.1))
                .frame(maxWidth: .infinity, maxHeight: 2)
            
            HStack(spacing: 0) {
                ForEach(TabViewItem.allCases, id: \.rawValue) { tabItem in
                    TabButton(tabItem: tabItem, animation: animation, currentTabItem: $currentTab) { pressedTabItem in
                        withAnimation(.spring()) {
                            currentTab = pressedTabItem
                        }
                    }
                }
            }
            .padding(.top, 8)
        }
    }
}

struct TabButton: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    var tabItem: TabViewItem
    var animation: Namespace.ID
    
    @Binding var currentTabItem: TabViewItem
    
    var onTapped: (TabViewItem) -> ()
    
    var body: some View {
        Image(systemName: tabItem.image)
            .font(currentTabItem == tabItem ? .headline : .body)
            .foregroundColor(currentTabItem == tabItem ? .white : .gray)
            .frame(width: 45, height: 45)
            .background {
                ZStack {
                    if currentTabItem == tabItem {
                        Circle()
                            .fill(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
                            .matchedGeometryEffect(id: "TabItem", in: animation)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .onTapGesture {
                onTapped(tabItem)
            }
        
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
