//
//  SettingsOption.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import Foundation

enum SettingsOption: String {
    case appColor = "App Color"
    case displayMode = "Display Mode"
    
    case about
    case rate
    
    case feedback
    case follow
    
    case termsOfUse = "Terms of Use"
    case privacyPolicy = "Privacy Policy"
    
    case logout
}

extension SettingsOption {
    var icon: String {
        switch self {
        case .appColor:
            return "circle.hexagongrid"
        case .displayMode:
            return "circle.lefthalf.filled"
        case .about:
            return "info.circle"
        case .rate:
            return "star"
        case .feedback:
            return "paperplane"
        case .follow:
            return "at"
        case .termsOfUse:
            return "doc"
        case .privacyPolicy:
            return "lock"
        case .logout:
            return "rectangle.portrait.and.arrow.forward"
        }
    }
}
