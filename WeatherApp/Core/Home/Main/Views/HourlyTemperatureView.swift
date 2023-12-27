//
//  HourlyTemperaturePlot.swift
//  WeatherApp
//
//  Created by Martyna on 07/11/2022.
//

import SwiftUI
import Charts

struct HourlyTemperatureView: View {
    
    var hourlyWeatherSet: HourlyWeather = HourlyWeather(hourly: Hourly(time: ["T0:00", "1:00"], temperature2M: [25, 22]))
    @State var temperaturePoints: [TemperaturePoint] = DeveloperPreview.instance.temperaturePoints
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            VStack(spacing: 0){
                temperaturePointsStack
            }
        }
    }
}

struct HourlyTemperaturePlot_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.cyan
            HourlyTemperatureView(temperaturePoints: dev.temperaturePoints)
                .frame(height: 150)
        }
    }
}


private extension HourlyTemperatureView  {
    var temperaturePointsStack: some View {
        HStack(spacing: CGFloat.size.largePadding){
            
            ForEach(hourlyWeatherSet.hourly.temperature2M.indices, id: \.self){ i in
                VStack(spacing: 0){
                    Text("\(hourlyWeatherSet.hourly.temperature2M[i].roundToCelsius())")
                    AnimatedView(name: "\(Theme(weatherType: .cloud).lottieName).json", shouldPlay: false)
                        .frame(width: CGFloat.size.regularIconFrame,
                               height: CGFloat.size.regularIconFrame)
                    Text("\(hourlyWeatherSet.hourly.time[i].removeUpToChar(char:"T"))")
                        .font(.subheadline)
                }
                .foregroundColor(Color.white)
                .font(.headline)
            }
        }
    }
}
