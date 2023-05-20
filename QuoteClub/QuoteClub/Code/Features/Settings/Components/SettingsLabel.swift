//
//  SettingsLabel.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import SwiftUI

struct SettingsLabel: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    let settingsOption: SettingsOption
    
    var body: some View {
        HStack {
            Image(systemName: settingsOption.icon)
                .fontWeight(.medium)
                .foregroundColor(settingsOption == .logout ? .red : AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
            
            Text(settingsOption.rawValue.capitalized)
        }
    }
}

struct SettingsLabel_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLabel(settingsOption: .appColor)
    }
}
