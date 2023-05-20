//
//  AboutView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import SwiftUI

struct AboutView: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    var body: some View {
        Form {
            ForEach(AboutQuoteClub.about, id: \.self) { item in
                Section {
                    DisclosureGroup {
                        Text(item.answer)
                    } label: {
                        Text(item.question)
                    }
                    .tint(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
                }
            }
            
            // Fixing Layout issues with custom toolbar
            Section { EmptyView() } footer: {
                Text("").padding(.bottom, 80)
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
