//
//  TemperaturePoint.swift
//  WeatherApp
//
//  Created by Martyna on 07/11/2022.
//

import Foundation


struct TemperaturePoint: Identifiable{
    let id = UUID()
    let temperature: Double
    let hour: Int
    let weatherType: WeatherType
}
