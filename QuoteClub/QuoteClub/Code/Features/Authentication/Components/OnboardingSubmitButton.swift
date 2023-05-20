//
//  OnboardingSubmitButton.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct OnboardingSubmitButton: View {
    
    let screenType: OnboardingScreenType
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(screenType.rawValue.capitalized)
                .padding()
                .font(.headline)
                .frame(maxWidth: .infinity)
                .foregroundColor(Color(UIColor.systemGray6))
        }
        .background(.primary)
        .cornerRadius(12)
        .padding(.vertical)
    }
}

struct OnboardingSubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSubmitButton(screenType: .login, action: {})
    }
}
