//
//  SavedLocationCardView.swift
//  WeatherApp
//
//  Created by Martyna on 08/11/2022.
//

import SwiftUI

struct SavedLocationCardView: View {
    
    var savedLocation: SavedLocation
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                Text(savedLocation.city)
                    .font(.title)
                Spacer()
                AnimatedView(name: Theme(weatherType: savedLocation.weatherType).lottieName)
                    .frame(width: 80, height: 80)
                Text(savedLocation.temperature)
                    .font(.title)
            }
            Spacer()
            HStack{
                Text(savedLocation.country)
                    .font(.headline)
                Spacer()
                Text("H: \(savedLocation.temperatureHigh)")
                Text("L: \(savedLocation.temperatureLow)")
                
            }
        }
        .padding()
        .foregroundColor(.white)
        .shadow(radius: 3, x: 0, y: 3)
        .modifier(CardViewModifier(weatherType: savedLocation.weatherType))
    }
}

struct SavedLocationCardView_Previews: PreviewProvider {
    static var previews: some View {
        SavedLocationCardView(savedLocation: dev.savedLocation1)
        .scaledToFit()
    }
}


