//
//  MainTabView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 10/05/2023.
//

import SwiftUI

struct MainTabView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var currentTab: TabViewItem = .home
    
    // For Matched Geometry Effect
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                HomeView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(TabViewItem.home)
                
                ExploreView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(TabViewItem.explore)
                
                SettingsView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tag(TabViewItem.settings)
            }
            
            CustomTabBar(animation: animation, currentTab: $currentTab)
                .background(colorScheme == .light ? .white : Color(UIColor.systemGray5))
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
