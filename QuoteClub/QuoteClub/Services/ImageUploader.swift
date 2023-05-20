//
//  ImageUploader.swift
//  QuoteClub
//
//  Created by Baher Tamer on 14/05/2023.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let filename = NSUUID().uuidString
        let reference = Storage.storage().reference(withPath: "/profileImages/\(filename)")
        
        reference.putData(imageData) { _, error in
            if let error {
                print("DEBUG: Failed to upload user profile image, \(error)")
                return
            }
            
            reference.downloadURL { imageURL, error in
                if let error {
                    print("DEBUG: Failed to download user profile image url, \(error)")
                    return
                }
                
                guard let imageURL = imageURL?.absoluteString else { return }
                completion(imageURL)
                print("DEBUG: Profile image uploaded successfully.")
            }
        }
    }
    
}
