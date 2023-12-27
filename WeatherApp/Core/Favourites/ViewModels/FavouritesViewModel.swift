//
//  FavouritesViewModel.swift
//  WeatherApp
//
//  Created by Martyna on 29/11/2022.
//

import Foundation
import Combine
import MapKit

@MainActor
class FavouritesViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    @Published var coordinates = []
    @Published var locations: [Datum] = []
    @Published var hasError = false
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var savedLocationsList: [SavedLocationDecode] = []
    @Published var savedLocationsWithWeather: [SavedLocation] = []
    
    @Published var choosenLocation: SavedLocationDecode = SavedLocationDecode(country: "",
                                                                              city: "",
                                                                              latitude: "",
                                                                              longitude: "")

    
    
    private let networkingManager: NetworkingManagerImpl!
    
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared){
        self.networkingManager = networkingManager
        refreshLocations()
        
    }
    
    
    /// Method that triggered when typing in search text field
    /// - Parameter text: provided data of searched place e.g. city name
    func onTextChange(text: String)  {
        locations = []
        Task{
            try await Task.sleep(nanoseconds: 500)
            await getListOfMatchingPlaces(for: text)
        }
    }
    
    
    /// Method to refresh list od saved location (e.g. after addition of new element)
    func refreshLocations(){
        savedLocationsList = []
        savedLocationsWithWeather = []
        savedLocationsList = UserDefaultsManager.getAllsavedLocations
        savedLocationsList.forEach{ element in
            addWeatherLocations(location: element)
        }
        print(savedLocationsList)
    }
    
    
    /// Private method to get places matching given string
    /// - Parameter address: provided data of searched place e.g. city name
    private func getListOfMatchingPlaces(for address: String) async {
        if address.count >= 3 {
            do {
                let response = try await networkingManager.request(session: .shared,
                                                                   .searchCity(city: address),
                                                                   type: Address.self)
                self.locations = response.data
                print(locations)
                
            } catch {
                self.hasError = true
                if let networkingError = error as? NetworkingManager.NetworkingError {
                    self.error = networkingError
                } else  {
                    self.error = .custom(error: error)
                }
                print(error)
                
            }
        }
    }
    
    
    
    /// DescriptionMethod responsible for adding chosen place ro User Defaults stored locations
    /// - Parameters:
    ///   - latitude: latitide od selected place
    ///   - longitude: longitude of selected place
    ///   - city: name
    ///   - country: country
    func addSavedLocation(latitude: String, longitude: String, city: String, country: String) {
        let weatherManager = WeatherManager(latitude: latitude, longitude: longitude)
        
        Task{
            await weatherManager.fetchCurrentWeather()
            weatherManager.specifyWeatherType()
            print(weatherManager.currentWeather)
            let location = SavedLocationDecode(country: country, city: city, latitude: latitude, longitude: longitude)
            savedLocationsList.append(location)
            UserDefaultsManager.saveAllLocations(allObjects: savedLocationsList)
            
        }
        
    }
    
    
    
    /// Method that sets up list of saved locatons with current weather based on coordinates
    /// - Parameter location: location that is saved when choosing feom map or list (does not contain current weather)
    func addWeatherLocations(location: SavedLocationDecode){
        let weatherManager = WeatherManager(latitude: location.latitude, longitude: location.longitude)
        Task{
            await weatherManager.fetchCurrentWeather()
            weatherManager.specifyWeatherType()
            let locationWithWeather = SavedLocation(country: location.country,
                                                    city: location.city,
                                                    hour: "11:20",
                                                    temperature: weatherManager.currentWeather.temperatureDetails.temp.roundTemperatureinCelsiusFromKelvin(),
                                                    temperatureHigh: weatherManager.currentWeather.temperatureDetails.tempMax.roundTemperatureinCelsiusFromKelvin(),
                                                    temperatureLow: weatherManager.currentWeather.temperatureDetails.tempMin.roundTemperatureinCelsiusFromKelvin(),
                                                    weatherType: weatherManager.weatherType)
            savedLocationsWithWeather.append(locationWithWeather)
        }
    }
    
    
    /// Method hansling swipe on saved locations
    /// - Parameter location: location to be removed both from User Defaults and list of locations with curent weather
    func deleteLocation(location: SavedLocation){
        if let index = savedLocationsList.enumerated().first(where: {$0.element.city == location.city}){
            savedLocationsList.remove(at: index.offset)
            let weatherLocationsFilteded = savedLocationsWithWeather.filter{ $0.city != location.city}
            savedLocationsWithWeather = weatherLocationsFilteded
            UserDefaultsManager.saveAllLocations(allObjects: savedLocationsList)
            
        }
    }
    
    
    func searchLocationFromCoordinates(latitude: String, longitude: String) async -> Bool  {
       
            do {
                var isFinished = false
                let response = try await self.networkingManager.request(session: .shared,
                                                                   .locationFromCoordinates(latitude: latitude,
                                                                                            longitude: longitude),
                                                                   type: [LocationElement].self)
                
                self.choosenLocation = SavedLocationDecode(country: response[0].country,
                                                           city: response[0].name,
                                                           latitude: latitude,
                                                           longitude: longitude)
                
                defer{
                    savedLocationsList.append(choosenLocation)
                    UserDefaultsManager.saveAllLocations(allObjects: savedLocationsList)
                    print(response)
                    refreshLocations()
                    isFinished = true
                }
                return isFinished
                    
            } catch {
                self.hasError = true
                if let networkingError = error as? NetworkingManager.NetworkingError {
                    self.error = networkingError
                } else  {
                    self.error = .custom(error: error)
                }
                print(error)
                return true
            }
        
        
    }
    
}
