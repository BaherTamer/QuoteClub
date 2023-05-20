//
//  RegisterView.swift
//  QuoteClub
//
//  Created by Baher Tamer on 12/05/2023.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var user: UserInputData = UserInputData(email: "", password: "", fullName: "", username: "")
    @State private var profileImage: UIImage?
    
    private var agreementText: some View {
        Text("By registering, you're agree to our [Terms & Conditions](apple.com) and [Privacy Policy](apple.com)")
            .padding(.vertical, 8)
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { _ in
                    
                    RegisterBackButton { dismiss() }
                    
                    ImagePicker { image in
                        profileImage = image
                    }
                    
                    Spacer()
                    
                    OnboardingTitle(screenType: .register)
                    
                    Group {
                        OnboardingTextField(type: .email, text: $user.email)
                        OnboardingTextField(type: .fullName, text: $user.fullName)
                        OnboardingTextField(type: .username, text: $user.username)
                        OnboardingTextField(type: .password, isSecure: true, text: $user.password)
                    }
                    
                    agreementText
                    
                    Spacer()
                    
                    OnboardingSubmitButton(screenType: .register) {
                        authViewModel.register(withUser: user, profileImage: profileImage)
                        dismiss()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .padding(.horizontal)
            .toolbar(.hidden, for: .navigationBar)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
