//
//  QuoteClubApp.swift
//  QuoteClub
//
//  Created by Baher Tamer on 10/05/2023.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct QuoteClubApp: App {
    
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var authViewModel = AuthViewModel()
    
    @StateObject private var displayModeManager = DisplayModeManager()
    
    @AppStorage("displayMode") var displayMode: DisplayMode = .unspecified
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .environmentObject(displayModeManager)
                .onChange(of: displayMode, perform: { newValue in
                    displayModeManager.applyColorScheme()
                })
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    displayModeManager.applyColorScheme()
                }
        }
    }
}
