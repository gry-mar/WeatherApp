//
//  MKCoordinateRegion.swift
//  WeatherApp
//
//  Created by Martyna on 30/11/2022.
//

import Foundation
import MapKit


extension MKCoordinateRegion {
    
    static func defaultRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 51.107883, longitude: 17.038538), latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
