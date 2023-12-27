//
//  DailyWeatherParameters.swift
//  WeatherApp
//
//  Created by Martyna on 09/12/2022.
//

import SwiftUI

struct DailyWeatherParameters: View {
    
    var title: String
    var detailedInfo: String
    var animationType: String
    var weatherType: WeatherType
    
    var body: some View {
        VStack{
            AnimatedView(name: animationType, shouldPlay: false)
                .frame(width: 80, height: 80)
            Text(title)
            Text(detailedInfo)
                .font(.subheadline)
            
        }
        .font(.title3)
        .foregroundColor(.white)
        .shadow(radius: 8)
        .padding()
        .modifier(CardViewModifier(weatherType: weatherType))
    }
}

struct DailyWeatherParameters_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherParameters(title: "Sunrise", detailedInfo: "7:24", animationType: "sunrise", weatherType: .sun)
    }
}
