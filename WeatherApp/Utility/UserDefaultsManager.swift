//
//  UserDefaultsManager.swift
//  WeatherApp
//
//  Created by Martyna on 07/12/2022.
//

import Foundation


///  Class that manages saving locations to UserDefaults
class UserDefaultsManager {
    
    
    /// All SavedLocationsDecode objects stored in UserDefaults
    static var getAllsavedLocations: [SavedLocationDecode] {
        let defaultLocationsList = SavedLocationDecode(country: "Dom",
                                                       city: "Wrocław",
                                                       latitude: "51.107883",
                                                       longitude: "17.038538")
        if let objects = UserDefaults.standard.value(forKey: "saved_locations") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [SavedLocationDecode] {
                return objectsDecoded
            } else {
                return [defaultLocationsList]
            }
        } else {
            return [defaultLocationsList]
        }
    }
    
    
    /// Method to save all SavedLocationsDecode list
    /// - Parameter allObjects: all locatons saved to favourites excluding current weather
    static func saveAllLocations(allObjects: [SavedLocationDecode]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects){
            UserDefaults.standard.set(encoded, forKey: "saved_locations")
        }
    }
}
