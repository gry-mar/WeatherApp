//
//  Color.swift
//  WeatherApp
//
//  Created by Martyna on 04/11/2022.
//

import Foundation
import SwiftUI


struct Theme {
    
    let weatherType: WeatherType
    
    var transparent = Color("Transparent")
    
    var backgroundTop: Color{
        switch weatherType {
        case .sun:
            return Color("BackgroundTopSun")
        case .rain:
            return Color("BackgroundTopRain")
        case .snow:
            return Color("BackgroundTopSnow")
        case .cloud:
            return Color("CloudyDarkGray")
        case .wind:
            return Color("WindyDarkGray")
        case .nightClear:
            return Color("BackgroundTopNight")
        }
    }
    var backgroundBottom: Color{
        switch weatherType {
        case .sun:
            return Color("CardBackgroundSun")
        case .rain:
            return Color("CardBackgroundRain")
        case .snow:
            return Color("LightSnow")
        case .cloud:
            return Color("CloudyLightBeige")
        case .wind:
            return Color("WIndyGreenGray")
        case .nightClear:
            return Color("CardBackgroundNight")
        }
    }
    
    var cardBackground: Color {
        switch weatherType {
        case .sun:
            return Color("CardBackgroundSun")
        case .rain:
            return Color("CardBackgroundRain")
        case .snow:
            return Color("CardBackgroundSnow")
        case .cloud:
            return Color("CloudyMediumGray")
        case .wind:
            return Color("WindyLightGray")
        case .nightClear:
            return Color("CardBackgroundNight")
        }
    }
    
    var lottieName: String {
        switch weatherType {
        case .sun:
            return "sunny"
        case .rain:
            return "rainy"
        case .snow:
            return "snow"
        case .cloud:
            return "cloudy"
        case .wind:
            return "windy"
        case .nightClear:
            return "clearNight"
        }
    }
    
}

enum WeatherType {
    case sun, snow, cloud, wind, nightClear, rain
}




