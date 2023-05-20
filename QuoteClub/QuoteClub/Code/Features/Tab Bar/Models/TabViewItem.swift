//
//  TabViewItem.swift
//  QuoteClub
//
//  Created by Baher Tamer on 10/05/2023.
//

import Foundation

enum TabViewItem: String, CaseIterable {
    case home
    case explore
    case settings
    
    var image: String {
        switch self {
        case .home:
            return "house.fill"
        case .explore:
            return "magnifyingglass"
        case .settings:
            return "gear"
        }
    }
}
