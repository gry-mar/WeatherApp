//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation


class CurrentWeatherViewModel: ObservableObject {
    
    var locationManager = LocationManager()
    @Published var latitude: String = ""
    @Published var longitude: String = ""
    @Published private(set) var currentWeather = CurrentWeather()
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var viewState: ViewState?
    @Published var hasError = false
    @Published var city: String = ""
    
    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared,
         latitude: String = "51.107883",
         longitude: String = "17.038538"){
        self.networkingManager = networkingManager
        self.latitude = latitude
        self.longitude = longitude
        
    }
    
    var isLoading: Bool {
        viewState == .loading
    }
    var isFetching: Bool {
        viewState == .fetching
    }
    
}


