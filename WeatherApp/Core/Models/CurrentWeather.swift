//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation


// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    var coord: Coord = Coord(longitude: 12, latitude: 12)
    var weather: [Weather] = [Weather( main: "Sunny")]
    var temperatureDetails: TemperatureDetails = TemperatureDetails(temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0)
    enum CodingKeys: String, CodingKey {
        case coord, weather
        case temperatureDetails = "main"
    }
}

// MARK: - Coordinates
struct Coord: Codable {
    let longitude: Double
    let latitude: Double
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}

struct TemperatureDetails: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}


// MARK: - Weather
struct Weather: Codable {
    let main: String
    enum CodingKeys: String, CodingKey {
        case main
    }
}
