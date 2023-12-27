//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Martyna on 18/11/2022.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

enum ViewState {
    case fetching
    case loading
    case finished
}


class WeatherManager: ObservableObject {
    
    @Published var city = ""
    var locationManager = LocationManager()
    @Published var latitude: String
    @Published var longitude: String
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    @Published private(set) var currentWeather = CurrentWeather()
    @Published private(set) var weatherType: WeatherType = .cloud
    @Published private(set) var hourlyWeather: HourlyWeather = HourlyWeather(hourly: Hourly(time: [],
                                                                                            temperature2M: []))
    @Published private(set) var calendarWeather: CalendarWeather = CalendarWeather(daily: Daily(time: [],
                                                                                                weathercode: [],
                                                                                                temperature2MMax: [],
                                                                                                temperature2MMin: []))
    
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared, latitude: String = "", longitude: String = ""){
        self.networkingManager = networkingManager
        self.latitude = latitude
        self.longitude = longitude
        if(latitude == "" && longitude == ""){
            getCurrentLocation()
        }
        
    }
    
    func getCurrentLocation(){
        guard let location: CLLocationCoordinate2D = locationManager.lastLocation?.coordinate else {
            latitude = "51.107883"
            longitude = "17.038538"
            print("FAILED")
            return
        }
        latitude = "\(location.latitude)"
        longitude = "\(location.longitude)"
        print("Location \(latitude)")
    }
    
    var isLoading: Bool {
        viewState == .loading
    }
    var isFetching: Bool {
        viewState == .fetching
    }
    
    
    @MainActor
    func fetchCalendar() async {
        viewState = .loading
        defer{
            viewState = .finished
        }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .calendarCompact(latitude: latitude,
                                                                                longitude: longitude),
                                                               type: CalendarWeather.self)
            self.calendarWeather = response
            
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
    
    @MainActor
    func fetchCurrentWeather() async {
        viewState = .loading
        defer{print(currentWeather)
            print(latitude)
            print(longitude)
            viewState = .finished
        }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .currentData(latitude: latitude,
                                                                            longitude: longitude),
                                                               type: CurrentWeather.self)
            self.currentWeather = response
            
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
    
    @MainActor
    func fetchHourlyyWeather() async {
        viewState = .loading
        let currentDateTime = Date()
        let format = DateFormatter()
        format.dateFormat = "yyy'-'MM'-'dd"
        let currentDate = format.string(from: currentDateTime)
        print(currentDate)
        defer{print(currentWeather)
            print(latitude)
            print(longitude)
            viewState = .finished
        
        }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .hourlyWeather(latitude: latitude,
                                                                              longitude: longitude,
                                                                              currentDate: currentDate),
                                                               type: HourlyWeather.self)
            self.hourlyWeather = response
            print(hourlyWeather)
            
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
    
    @MainActor
    func fetchLocationFromCoordinates() async {
        viewState = .loading
        defer{viewState = .finished
        }
        do {
            let response = try await networkingManager.request(session: .shared,
                                                               .locationFromCoordinates(latitude: latitude,
                                                                                        longitude: longitude),
                                                               type: [LocationElement].self)
            self.city = response[0].name
        } catch {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else  {
                self.error = .custom(error: error)
                print(error)
            }
            print(error)
        }
    }
    
    func specifyWeatherType(){
        let weatherDescription = currentWeather.weather.description.lowercased()
        if weatherDescription.contains("rain"){
            weatherType = .rain
        }
        else if weatherDescription.contains("sun") || weatherDescription.contains("clear"){
            weatherType = .sun
        }
        else if weatherDescription.contains("wind"){
            weatherType = .wind
        }
        else if weatherDescription.contains("snow"){
            weatherType = .snow
        }
        else {
            weatherType = .cloud
        }
    }
    
    func refresh() {
        
        getCurrentLocation()
        Task{
            await fetchCurrentWeather()
            await fetchLocationFromCoordinates()
            await fetchHourlyyWeather()
            await fetchCalendar()
        }
        specifyWeatherType()
    }
    
    
    
    func getWeatherTypeFromCode(code: Int) -> WeatherType {
        if [71, 73, 75, 77, 85, 86].contains(code){
            return .snow
        }
        else if [80, 81, 82, 61, 63, 65, 66, 67].contains(code){
            return .rain
        }
        else if [0, 1, 2].contains(code) {
            return .sun
        }
        else if [51, 53, 55, 56, 57, 95, 96, 99].contains(code){
            return .wind
        } else {
            return .cloud
        }
    }
    
    
}
