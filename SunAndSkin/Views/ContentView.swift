//
//  ContentView.swift
//  SunAndSkin
//
//  Created by Madison Thantu on 4/15/24.

//  Tutorial: https://nabendu82.medium.com/beginners-weather-app-in-swiftui-1820b08e18e1

import SwiftUI

struct ContentView: View {
//    @StateObject var locationManager = LocationManager()
    @EnvironmentObject var locationManager: LocationManager
    @State private var openingPage = true
    let date = Date()
    var body: some View {
        if openingPage {
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
                Button("Click to continue") {
                    withAnimation {
                        openingPage.toggle()
                    }
                }
                .foregroundColor(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                                gradient: Gradient(
                                    colors: [.pink, .white]
                                ), startPoint: .trailing, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all))
        } else {
            VStack {
                    WelcomeView()
                            .environmentObject(locationManager)
            }
            .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .preferredColorScheme(.dark)
            if let location = locationManager.location {
                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
            }
            else {
                    if locationManager.isLoading {
                            ProgressView()
                    } else {
                            WelcomeView()
                                    .environmentObject(locationManager)
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
