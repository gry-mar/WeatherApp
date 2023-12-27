//
//  Location.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation

struct LocationElement: Codable {
    var name: String = ""
    var country: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name, country
    }
}
