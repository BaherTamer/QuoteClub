//
//  RegisterBackButton.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct RegisterBackButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "arrow.left.circle.fill")
                .font(.title)
                .tint(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
        }
    }
}

struct RegisterBackButton_Previews: PreviewProvider {
    static var previews: some View {
        RegisterBackButton(action: {})
    }
}
