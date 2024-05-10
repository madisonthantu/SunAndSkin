//
//  BaseView.swift
//  SunAndSkin
//
//  Created by Madison Thantu on 5/9/24.
//

import SwiftUI

struct BorderedCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 1)
            )
            .foregroundColor(Color.blue)
    }
}

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        Image(systemName: "sun.max.fill").resizable()
            .foregroundStyle(Color(hue: 0.1639, saturation: 1, brightness: 1))
            .frame(width: 48.0, height: 48.0)
            .padding([.top], 20)
        content
            .font(.system(size: 32, weight: .regular, design: .rounded))
            .fontWeight(.heavy)
            .foregroundColor(Color.cyan)
        
    }
}

struct BaseView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(
                gradient: Gradient(
                    colors: [.pink, .white]
                ), startPoint: .trailing, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all))
    }
}

extension View {
    func borderedCaption() -> some View {
        modifier(BorderedCaption())
    }
    
    func header() -> some View {
        modifier(Header())
    }
    
    func baseView() -> some View {
        modifier(BaseView())
    }
}
