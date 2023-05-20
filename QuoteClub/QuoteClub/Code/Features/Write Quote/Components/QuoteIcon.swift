//
//  QuoteIcon.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

enum QuoteIconType: String {
    case opening = "quote.opening"
    case closing = "quote.closing"
}

struct QuoteIcon: View {
    
    let iconType: QuoteIconType
    
    var body: some View {
        Image(systemName: iconType.rawValue)
            .frame(maxHeight: .infinity, alignment: iconType == .opening ? .top : .bottom)
            .font(.footnote)
            .padding(.vertical, 8)
    }
}

struct QuoteIcon_Previews: PreviewProvider {
    static var previews: some View {
        QuoteIcon(iconType: .opening)
    }
}
