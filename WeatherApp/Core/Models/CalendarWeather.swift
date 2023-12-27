//
//  CalendarWeather.swift
//  WeatherApp
//
//  Created by Martyna on 23/11/2022.
//

import Foundation

// MARK: - CalendarWeather
struct CalendarWeather: Codable {
    
    var daily: Daily
    
    enum CodingKeys: String, CodingKey {
        case daily
    }
}

// MARK: - Daily
struct Daily: Codable {
    var time: [String] = []
    var weathercode: [Int]
    var temperature2MMax, temperature2MMin: [Double]
    
    enum CodingKeys: String, CodingKey {
        case time, weathercode
        case temperature2MMax = "temperature_2m_max"
        case temperature2MMin = "temperature_2m_min"
    }
}

