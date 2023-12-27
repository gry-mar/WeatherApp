//
//  CurrentWeatherDetailView.swift
//  WeatherApp
//
//  Created by Martyna on 04/11/2022.
//

import SwiftUI
import Lottie

struct CurrentWeatherDetailView: View {
    
    var city: String
    var weatherType: WeatherType
    var currentWeather: CurrentWeather
    var yOffset = CGFloat(0.0)
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading){
                Text(city)
                    .font(.custom("SF Pro", size: calculateSizes(maxHeight: 40, minHeight: 20),
                                  relativeTo: .title))
                    .foregroundColor(Color.white)
                    .shadow(radius: CGFloat.size.standardShadowRadius,
                            x: 0,
                            y: CGFloat.size.standadShadowYAxis)
                HStack() {
                    
                    dailyWeatherInfoVStack
                    AnimatedView(name:
                                    "\(Theme(weatherType: weatherType).lottieName).json")
                    .frame(width: calculateSizes(maxHeight: 124, minHeight: 44),
                           height: calculateSizes(maxHeight: 124, minHeight: 44))
                    Spacer()
                }
            }
        }
        
    }
}

struct CurrentWeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherDetailView(city: "Wrocław", weatherType: .rain, currentWeather: CurrentWeather())
            .padding()
            .background(
                Rectangle()
                    .cornerRadius(CGFloat.size.largeCornerRadius)
                    .foregroundColor(Theme(weatherType: .rain).backgroundTop)
            )
    }
}

private extension CurrentWeatherDetailView {
    var dailyWeatherInfoVStack: some View {
        VStack(alignment: .leading){
            
            Text("\(currentWeather.temperatureDetails.temp.roundTemperatureinCelsiusFromKelvin())")
                .font(.custom("SF Pro", size: calculateSizes(maxHeight: 72, minHeight: 36),
                              relativeTo: .largeTitle))
            Text(currentWeather.weather[0].main)
                .font(.title3)
            HStack {
                Text("Min: \(currentWeather.temperatureDetails.tempMin.roundTemperatureinCelsiusFromKelvin())")
                Text("Max: \(currentWeather.temperatureDetails.tempMax.roundTemperatureinCelsiusFromKelvin())")
            }
            .font( .custom("SF Pro",
                           size: calculateSizes(maxHeight: 20, minHeight: 0),
                           relativeTo: .title3))
        }
        .foregroundColor(Color.white)
        .shadow(radius: CGFloat.size.standardShadowRadius,
                x: 0,
                y: CGFloat.size.standadShadowYAxis)
    }
}


extension CurrentWeatherDetailView {
    
    func calculateSizes(maxHeight: CGFloat, minHeight: CGFloat) -> CGFloat{
        
        if maxHeight + yOffset < minHeight {
            // SCROLLING UP
            // Never go smaller than our minimum height
            
            return minHeight
        }
        else if maxHeight + yOffset > maxHeight {
            // SCROLLING DOWN PAST MAX HEIGHT
            return maxHeight // Lessen the offset
        }
        
        // Return an offset that is between the min and max heights
        return maxHeight + yOffset
    }
}
