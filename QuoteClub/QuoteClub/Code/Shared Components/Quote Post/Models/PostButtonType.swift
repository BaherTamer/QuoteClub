//
//  PostButtonType.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

enum PostButtonType {
    case like
    case save
}

extension PostButtonType {
    var icon: String {
        switch self {
        case .like:
            return "heart"
        case .save:
            return "bookmark"
        }
    }
    
    var iconFilled: String {
        icon + ".fill"
    }
}

extension PostButtonType {
    var color: Color {
        switch self {
        case .like:
            return .red
        case .save:
            return .orange
        }
    }
}
