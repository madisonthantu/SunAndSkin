//
//  WelcomeView.swift
//  SunAndSkin
//
//  Created by Madison Thantu on 4/15/24.
//

import Foundation
import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
//    @EnvironmentObject var locationManager: LocationManager
    @StateObject var locationManager = LocationManager()
    @State private var firstOpen = true
    var body: some View {
        VStack {
            ZStack {
                Image("sun").resizable()
                    .frame(width: 50.0, height: 50.0)
                    .offset(x: 15.0, y: -15.0)
                Image("skincare").resizable()
                    .frame(width: 50.0, height: 50.0)
                    .offset(x: -15.0, y: 10.0)
            }.offset(y: -20)
            Text("Sun & Skin")
                .multilineTextAlignment(.center)
                .padding()
                .font(
                    Font.custom(
                        "Pacifico",
                        fixedSize: 35)
                    .weight(.heavy)
                )
                .foregroundColor(.white)
                .offset(y: -40)
            if firstOpen {
                Button("Click to continue") {
                    withAnimation {
                        firstOpen.toggle()
                    }
                }
                .foregroundColor(Color.white)
            }
            else {
                if let location = locationManager.location {
                    Text("Your coordinates are: \(location.longitude), \(location.latitude)")
                }
                else {
                    LocationButton(.shareCurrentLocation) {
                            locationManager.requestLocation()
                    }
                    .cornerRadius(30)
                    .symbolVariant(.fill)
                    .foregroundColor(.white)
                    .padding()
                    if locationManager.isLoading {
                        Text("Loading location ...")
                        ProgressView()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(
            gradient: Gradient(
                colors: [.pink, .white]
            ), startPoint: .trailing, endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    WelcomeView()
}
