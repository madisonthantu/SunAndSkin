//
//  ContentView.swift
//  SunAndSkin
//
//  Created by Madison Thantu on 4/15/24.

//  Tutorial: https://nabendu82.medium.com/beginners-weather-app-in-swiftui-1820b08e18e1

import SwiftUI

struct ContentView: View {
//    var body: some View {
//        ZStack {
//            LinearGradient(
//                gradient: Gradient(
//                    colors: [.pink, .white]
//                ), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .edgesIgnoringSafeArea(.all)
//            VStack {
//                Text("Sun & Skin")
//            }
//        }
//    }
    @State private var openingPage = true
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
                }
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
                    .offset(y: -20)
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
//            MainPageView()
        }
    }
}

#Preview {
    ContentView()
}
