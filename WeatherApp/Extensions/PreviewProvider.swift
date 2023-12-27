//
//  PreviewProvider.swift
//  WeatherApp
//
//  Created by Martyna on 07/11/2022.
//

import Foundation
import SwiftUI

extension PreviewProvider {

    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }

}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let temperaturePoints = [
        TemperaturePoint(temperature: 250, hour: 1, weatherType: .snow),
    TemperaturePoint(temperature: 330, hour: 2, weatherType: .rain),
    TemperaturePoint(temperature: 220, hour: 3, weatherType: .sun),
    TemperaturePoint(temperature: 225, hour: 4, weatherType: .snow),
    TemperaturePoint(temperature: 270, hour: 5, weatherType: .snow),
    TemperaturePoint(temperature: 280, hour: 6, weatherType: .snow),
    TemperaturePoint(temperature: 290, hour: 7, weatherType: .snow),
    TemperaturePoint(temperature: 290, hour: 8, weatherType: .sun),
    TemperaturePoint(temperature: 290, hour: 9, weatherType: .snow),
    TemperaturePoint(temperature: 240, hour: 10, weatherType: .snow),
    TemperaturePoint(temperature: 290, hour: 11, weatherType: .snow),
    TemperaturePoint(temperature: 300, hour: 12, weatherType: .snow),
    
    ]
    
    var savedLocation1 = SavedLocation(country: "PL", city: "Wrocław", hour: "15:12", temperature: "26°",temperatureHigh: "25°", temperatureLow: "0°", weatherType: .wind)
    let savedLocation2 = SavedLocation(country: "DE", city: "Berlin", hour: "15:11", temperature: "20°", temperatureHigh: "25°", temperatureLow: "0°", weatherType: .cloud)
    
}

