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
    @State private var currDate = [
        "dayOfWeek": Date.now.formatted(Date.FormatStyle().weekday(.abbreviated)),
        "date": Date.now.formatted(Date.FormatStyle().day().month().year())
    ]
    var body: some View {
        VStack 
        {
//            Text("HELOOOOO")
//                .borderedCaption()
            Text("Chelsea")
                .header()
            Text("\(currDate["dayOfWeek"] ?? "") \(currDate["date"] ?? "")")
                .padding([.top], 50)
            Text("\(Date.now.formatted(Date.FormatStyle().hour().minute()))")
            Spacer()
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
            if let location = locationManager.location {
                Text("Your coordinates are: \(location.longitude), \(location.latitude)")
//                Text(currDate["dayOfWeek"] ?? "")
                Button("Click to continue") {
                    withAnimation {
                        firstOpen.toggle()
                    }
                }
            }
            else if locationManager.isLoading {
                Text("Loading ...")
                ProgressView()
            }
            else {
                LocationButton(.shareCurrentLocation) {
                        locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
                .padding()
            }
            Spacer()
        }
        .baseView()
    }
}

#Preview {
    WelcomeView()
}
