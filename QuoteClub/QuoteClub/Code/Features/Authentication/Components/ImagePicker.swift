//
//  ImagePicker.swift
//  QuoteClub
//
//  Created by Baher Tamer on 14/05/2023.
//

import SwiftUI
import PhotosUI

struct ImagePicker: View {
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: UIImage?
    
    var action: (UIImage) -> Void
    
    var body: some View {
        PhotosPicker(selection: $selectedItem) {
            Group {
                if let selectedImage {
                    Image(uiImage: selectedImage)
                        .onboardingImage()
                        .clipShape(Circle())
                } else {
                    Image(systemName: "photo.circle")
                        .onboardingImage()
                        .tint(.primary)
                }
            }
            .frame(width: 180, height: 180)
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selectedImage = UIImage(data: data)
                    action(selectedImage!)
                }
            }
        }
        
    }
}

extension Image {
    func onboardingProfileImage() -> some View {
        self
            .resizable()
            .scaledToFill()
    }
}

struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ImagePicker(action: { _ in })
    }
}
