//
//  Double.swift
//  WeatherApp
//
//  Created by Martyna on 10/11/2022.
//

import Foundation

extension Double {
    
    func kelvinToCelsius() -> Double{
        return self - 272.15
    }
    
    func roundTemperatureinCelsiusFromKelvin() -> String {
        let roundedValue = self.kelvinToCelsius().rounded()
        return String(format: "%.0f", roundedValue) + "°"
    }
    
    func roundToCelsius() -> String {
        return String(format: "%.0f", self) + "°"
    }
}
