//
//  CardViewModifier.swift
//  WeatherApp
//
//  Created by Martyna on 08/11/2022.
//

import SwiftUI

struct CardViewModifier: ViewModifier {
    
    var weatherType: WeatherType
    
    func body(content: Content) -> some View {
        ZStack{
            Rectangle()
                .cornerRadius(CGFloat.size.mediumCornerRadius)
                .foregroundColor(Theme(weatherType: weatherType).cardBackground)
                .opacity(CGFloat.size.secondaryItemOpacity)
                .shadow(radius: CGFloat.size.standardShadowRadius,
                        x: 0,
                        y: CGFloat.size.standadShadowYAxis)
                .blur(radius: 0.5)
            content
        }
    }
}

