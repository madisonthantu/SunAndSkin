//
//  SunAndSkinApp.swift
//  SunAndSkin
//
//  Created by Madison Thantu on 4/15/24.
//

import Foundation
import SwiftUI
import CoreLocationUI

@main
struct SunAndSkinApp: App {
    @StateObject private var locationManager = LocationManager()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(locationManager) // Passed through the environment.
        }
    }
}
