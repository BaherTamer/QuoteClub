//
//  DisplayModeSettings.swift
//  QuoteClub
//
//  Created by Baher Tamer on 17/05/2023.
//

import SwiftUI

enum DisplayMode: Int {
    case unspecified, light, dark
}

class DisplayModeManager: ObservableObject {
    
    @AppStorage("displayMode") var displayMode: DisplayMode = .unspecified {
        didSet {
            applyColorScheme()
        }
    }
    
    func applyColorScheme() {
        keyWindow?.overrideUserInterfaceStyle = UIUserInterfaceStyle(rawValue: displayMode.rawValue)!
    }
    
    var keyWindow: UIWindow? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let windowSceneDelegate = scene.delegate as? UIWindowSceneDelegate,
              let window = windowSceneDelegate.window else {
            return nil
        }
        
        return window
    }
}
