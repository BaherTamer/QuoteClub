//
//  LoremText.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import SwiftUI

struct LoremText: View {
    
    let title: SettingsOption
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(AboutQuoteClub.lorem)
                .padding()
                .padding(.bottom, 80)
        }
        .navigationTitle(title.rawValue.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoremText_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoremText(title: .termsOfUse)
        }
    }
}
