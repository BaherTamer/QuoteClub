//
//  OnboardingImage.swift
//  QuoteClub
//
//  Created by Baher Tamer on 13/05/2023.
//

import SwiftUI

struct OnboardingImage: View {
    
    let screenType: OnboardingScreenType
    
    private var image: Image {
        switch screenType {
        case .login:
            return Image("Login")
        case .register:
            return Image("Register")
        }
    }
    
    var body: some View {
        image.onboardingImage()
    }
}

extension Image {
    func onboardingImage() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
}

struct OnboardingImage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingImage(screenType: .login)
    }
}
