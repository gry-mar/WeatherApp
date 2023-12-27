//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Martyna on 10/11/2022.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

class HomeViewModel: ObservableObject {
    
    @EnvironmentObject var weatherManager: WeatherManager
    
    func refresh() {
       
        weatherManager.refresh()
    }
}


