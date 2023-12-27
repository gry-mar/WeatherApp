//
//  Places.swift
//  WeatherApp
//
//  Created by Martyna on 01/12/2022.
//

import Foundation
import MapKit

struct Address: Codable {
    let data: [Datum]
}

struct Datum: Codable, Identifiable {
    let id = UUID()
    let latitude, longitude: Double
    var name: String = ""
    var region: String = ""
    var country: String = ""
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let region: String
    let country: String
    let coordinates: CLLocationCoordinate2D
}
