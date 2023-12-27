//
//  TemperatureColor.swift
//  WeatherApp
//
//  Created by Martyna on 10/11/2022.
//

import Foundation
import SwiftUI

struct TemperaureColor{
    
    let temperature: Double
    
    var color: Color{
        switch temperature{
        case (...10):
            return .blue
        case (10...20):
            return .green
        case (20...26):
            return .orange
        default:
            return .red
            
        }
    }
}
