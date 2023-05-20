//
//  SettingsView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 11/05/2023.
//

import StoreKit
import SwiftUI

struct SettingsView: View {
    
    @Environment(\.requestReview) var requestReview
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var displayModeManager: DisplayModeManager
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    appColorPicker
                    displayModePicker
                } header: {
                    Text("Apperence")
                }
                
                Section {
                    aboutRow
                    rateRow
                    
                } header: {
                    Text("QuoteClub")
                }
                
                Section {
                    NavigationLink {
                        FeedbackView()
                    } label: {
                        SettingsLabel(settingsOption: .feedback)
                    }

                    
                    linkRow
                } header: {
                    Text("Developer")
                }
                
                Section {
                    moreSectionRows
                } header: {
                    Text("More")
                }
                
                Section {
                    logoutButton
                } header: {
                    Text("Danger Zone")
                }
                
                Section {
                    EmptyView()
                } footer: {
                    VStack {
                        Text("QuoteClub")
                        Text("v1.2.1")
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.bottom, 80)
                
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var appColorPicker: some View {
        Picker(selection: $appColor) {
            ForEach(AppColor.allCases, id: \.rawValue) { color in
                Text(color.rawValue.capitalized)
                    .foregroundColor(color.color)
            }
        } label: {
            SettingsLabel(settingsOption: .appColor)
        }
    }
    
    var displayModePicker: some View {
        Picker(selection: displayModeManager.$displayMode) {
            Text("Light").tag(DisplayMode.light)
            Text("Dark").tag(DisplayMode.dark)
            Text("System").tag(DisplayMode.unspecified)
        } label: {
            SettingsLabel(settingsOption: .displayMode)
        }
    }
    
    var aboutRow: some View {
        NavigationLink {
            AboutView()
        } label: {
            SettingsLabel(settingsOption: .about)
        }
    }
    
    var rateRow: some View {
        HStack {
            Button {
                requestReview()
            } label: {
                SettingsLabel(settingsOption: .rate)
            }
            .tint(.primary)
            
            externalArrowIcon
        }
    }
    
    var linkRow: some View {
        HStack {
            Link(destination: URL(string: "https://www.linkedin.com/in/bahertamer/")!) {
                SettingsLabel(settingsOption: .follow)
            }
            .tint(.primary)
            
            externalArrowIcon
        }
    }
    
    var externalArrowIcon: some View {
        Group {
            Spacer()
            
            Image(systemName: "arrow.up.forward")
                .foregroundColor(Color(UIColor.systemGray3))
                .fontWeight(.medium)
        }
    }
    
    var moreSectionRows: some View {
        Group {
            NavigationLink {
                LoremText(title: .termsOfUse)
            } label: {
                SettingsLabel(settingsOption: .termsOfUse)
            }
            
            NavigationLink {
                LoremText(title: .privacyPolicy)
            } label: {
                SettingsLabel(settingsOption: .privacyPolicy)
            }
        }
    }
    
    var logoutButton: some View {
        Button(role: .destructive) {
            authViewModel.signOut()
        } label: {
            SettingsLabel(settingsOption: .logout)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(AuthViewModel())
            .environmentObject(DisplayModeManager())
    }
}
