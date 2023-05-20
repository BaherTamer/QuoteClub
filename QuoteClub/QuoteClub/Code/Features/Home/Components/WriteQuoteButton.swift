//
//  WriteQuoteButton.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct WriteQuoteButton: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus.bubble")
                .padding()
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .background(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
                .clipShape(Circle())
                .padding(.bottom, 80)
                .padding(.trailing)
        }
    }
}

struct WriteQuoteButton_Previews: PreviewProvider {
    static var previews: some View {
        WriteQuoteButton(action: {})
    }
}
