//
//  Posture_CheckApp.swift
//  Posture Check
//
//  Created by Luis Rivera Rivera on 8/27/22.
//

import SwiftUI

@main
struct Posture_CheckApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environmentObject(appDelegate.user)
        }
    }
}
