//
//  HourlyWeather.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation
struct HourlyWeather: Codable {
    let hourly: Hourly
    
    enum CodingKeys: String, CodingKey {
        case hourly
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]
    let temperature2M: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
    }
}

