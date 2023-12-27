//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Martyna on 09/11/2022.
//

import Foundation


struct SavedLocation: Identifiable{
    var id = UUID()
    let country: String
    let city: String
    let hour: String
    let temperature: String
    let temperatureHigh: String
    let temperatureLow: String
    let weatherType: WeatherType
}



struct SavedLocationDecode: Codable {
    let country: String
    let city: String
    let latitude: String
    let longitude: String
    
    enum CodingKeys: String, CodingKey {
        case country
        case city
        case latitude
        case longitude
    }
}

