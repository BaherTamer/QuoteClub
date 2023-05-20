//
//  FeedbackView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 18/05/2023.
//

import SwiftUI

struct FeedbackView: View {
    
    @AppStorage("appColor") private var appColor = AppColor.indigo.rawValue
    
    @State private var email = ""
    @State private var message = ""
    
    var body: some View {
        Form {
            Section {
                EmptyView()
            } footer: {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Help Improve QuoteClub")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text("You can share your inquire, suggestion, complaint, or other.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
            
            Section {
                TextField("Email", text: $email, prompt: Text("Email (Optional)"), axis: .vertical)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
            }
            
            Section {
                TextField("Message", text: $message, prompt: Text("Write your message..."), axis: .vertical)
                    .lineLimit(10, reservesSpace: true)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.sentences)
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
        .navigationBarTitle("Feedback")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Send Message
                    self.email = ""
                    self.message = ""
                } label: {
                    Image(systemName: SettingsOption.feedback.icon + ".fill")
                }
                .tint(AppColor(rawValue: appColor.lowercased())?.color ?? .indigo)
            }
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedbackView()
        }
    }
}
