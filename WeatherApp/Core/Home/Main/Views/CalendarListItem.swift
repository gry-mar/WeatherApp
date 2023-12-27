//
//  CalendarListItem.swift
//  WeatherApp
//
//  Created by Martyna on 07/11/2022.
//

import SwiftUI

struct CalendarListItem: View {
    
    var temperatureMin: Double
    var temperatureMax: Double
    var weatherType: WeatherType
    var date: String
    var calendarViewModel = CalendarViewModel()
    
    var body: some View {
        HStack{
            Text(calendarViewModel.getWeekDay(stringDate: date))
                .padding(.trailing, CGFloat.size.largePadding)
                .frame(width: 70)
            Spacer()
            AnimatedView(name: Theme(weatherType: weatherType).lottieName, shouldPlay: false)
                .frame(width: CGFloat.size.mediumIconFrame,
                       height: CGFloat.size.mediumIconFrame)
            Spacer()
            Text("\(temperatureMin.roundToCelsius())")
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [TemperaureColor(temperature: temperatureMin).color,
                                                               TemperaureColor(temperature: temperatureMax).color]),
                                   startPoint: .leading,
                                   endPoint: .bottom))
                .frame(height: 8)
            Spacer()
            Text("\(temperatureMax.roundToCelsius())")
        }
        .foregroundColor(Color.white)
        .font(.headline)
        .padding()
    }
}

struct CalendarListItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Theme(weatherType: .sun).cardBackground
                .ignoresSafeArea()
            CalendarListItem(temperatureMin: 20, temperatureMax: 10, weatherType: .rain, date: "2022-11-11")
        }
    }
}
