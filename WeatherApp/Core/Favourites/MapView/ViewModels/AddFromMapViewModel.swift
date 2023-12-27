//
//  AddFromMapViewModel.swift
//  WeatherApp
//
//  Created by Martyna on 06/12/2022.
//

import Foundation
import Combine
import MapKit


@MainActor
class AddFromMapViewModel: ObservableObject {
    
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    @Published var coordinates = []
    @Published var locations: [Datum] = []
    @Published var hasError = false
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var savedLocationsList: [SavedLocationDecode] = []
    @Published var choosenLocation: SavedLocationDecode = SavedLocationDecode(country: "",
                                                                              city: "",
                                                                              latitude: "",
                                                                              longitude: "")

    private let networkingManager: NetworkingManagerImpl!
    
    init(networkingManager: NetworkingManagerImpl = NetworkingManager.shared){
        self.networkingManager = networkingManager
        savedLocationsList = UserDefaultsManager.getAllsavedLocations
        print(savedLocationsList)
    }
    
    
    
    func setPlaces() {
        UserDefaultsManager.saveAllLocations(allObjects: savedLocationsList)
        
        
    }
    
    
    
}
