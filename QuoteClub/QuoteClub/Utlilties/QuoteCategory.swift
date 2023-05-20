//
//  QuoteCategory.swift
//  QuoteClub
//
//  Created by Baher Tamer on 11/05/2023.
//

import Foundation

enum QuoteCategory: String, CaseIterable {
    
    case affirmations
    case art
    case beauty
    case college
    case death
    case depression
    case faith
    case fitness
    case funny
    case future
    case health
    case heartbroken
    case leadership
    case love
    case marriage
    case men
    case money
    case motivation
    case overthinking
    case productivity
    case relationships
    case single
    case sleep
    case study
    case success
    case tips
    case women
    
    var description: String {
        "This is a description of what the \(self.rawValue.capitalized) category is about."
    }
    
}

extension QuoteCategory {
    var icon: String {
        switch self {
            
        case .affirmations:
            return "✨"
            
        case .art:
            return "🎨"
            
        case .beauty:
            return "🌸"
            
        case .college:
            return "🎓"
            
        case .death:
            return "🪦"
            
        case .depression:
            return "🌧️"
            
        case .faith:
            return "🙏"
            
        case .fitness:
            return "👟"
            
        case .funny:
            return "😂"
            
        case .future:
            return "🔮"
            
        case .health:
            return "🫀"
            
        case .heartbroken:
            return "💔"
            
        case .leadership:
            return "🧑‍✈️"
            
        case .love:
            return "💌"
            
        case .marriage:
            return "💍"
            
        case .men:
            return "🚹"
            
        case .money:
            return "💰"
            
        case .motivation:
            return "🔥"
            
        case .overthinking:
            return "💭"
            
        case .productivity:
            return "🏗️"
            
        case .relationships:
            return "👥"
            
        case .single:
            return "👤"
            
        case .sleep:
            return "🛏️"
            
        case .study:
            return "📚"
            
        case .success:
            return "🏅"
            
        case .tips:
            return "💡"
            
        case .women:
            return "🚺"
        }
    }
}
