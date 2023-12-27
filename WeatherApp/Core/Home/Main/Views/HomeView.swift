//
//  HomeView.swift
//  WeatherApp
//
//  Created by Martyna on 07/11/2022.
//

import SwiftUI


struct HomeView: View {
    @State private var itemName: String = ""
    @EnvironmentObject var weatherManager: WeatherManager
    @StateObject var viewModel = HomeViewModel()
    @State private var hasAppeared = false
    @State private var contentOffset = CGFloat(0)
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                let maxHeight = geo.size.height / 3
                let minHeight = geo.size.height / 6
                if weatherManager.isLoading{
                    ProgressView()
                        .frame(width: geo.size.width, height: geo.size.height)
                } else{
                    GeometryReader { reader in
                        CurrentWeatherDetailView(city: weatherManager.city,
                                                 weatherType: weatherManager.weatherType,
                                                 currentWeather: weatherManager.currentWeather,
                                                 yOffset: reader.frame(in: .global).origin.y)
                        
                        .frame(height: self.calculateHeight(minHeight: minHeight, maxHeight: maxHeight,
                                                            yOffset: reader.frame(in: .global).origin.y))
                        .padding(.horizontal, CGFloat.size.regularPadding)
                        .padding(.vertical, 64)
                        .background(LinearGradient(colors: [Theme(weatherType: weatherManager.weatherType).backgroundTop,
                                                            Theme(weatherType: weatherManager.weatherType).backgroundTop],
                                                   startPoint: .topLeading, endPoint: .bottomTrailing))
                        .mask(LinearGradient(colors: [Theme(weatherType: weatherManager.weatherType).backgroundTop,
                                                      Theme(weatherType: weatherManager.weatherType).backgroundBottom,
                                                      Theme(weatherType: weatherManager.weatherType).backgroundBottom.opacity(0)],
                                             startPoint: .center, endPoint: .bottom))
                        .offset(y: reader.frame(in: .global).origin.y < 0
                                ? abs(reader.frame(in: .global).origin.y)
                                : -reader.frame(in: .global).origin.y)
                    }
                    hourlyAndCalendarStack
                        .zIndex(-1)
                        .padding(.top, maxHeight + 64 )
                }
            }
            .edgesIgnoringSafeArea(.top)
            .background(LinearGradient(
                colors: [Theme(weatherType: weatherManager.weatherType).backgroundTop,
                         Theme(weatherType: weatherManager.weatherType).backgroundBottom],
                startPoint: .top, endPoint: .bottom))
            .refreshable {
                weatherManager.refresh()
            }
            .task{
                if !hasAppeared{
                    weatherManager.refresh()
                    hasAppeared = true
                }
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(WeatherManager())
    }
}


private extension HomeView {
    
    func calculateHeight(minHeight: CGFloat, maxHeight: CGFloat,
                         yOffset: CGFloat) -> CGFloat {
        if maxHeight + yOffset < minHeight {
            return minHeight
        }
        else if maxHeight + yOffset > maxHeight {
            return maxHeight + (yOffset * 0.5)
        }
        return maxHeight + yOffset
    }
    
    
    var yesterdayTemperatureRow: some View {
        HStack{
            Text("Calendar")
            Spacer()
            Image(systemName: "calendar")
        }
        .foregroundColor(.white)
        .font(.subheadline)
        .padding()
    }
    
    var hourlyAndCalendarStack: some View {
        VStack{
            HourlyTemperatureView(hourlyWeatherSet: weatherManager.hourlyWeather)
                .padding([.horizontal, .vertical], CGFloat.size.regularPadding)
                .modifier(CardViewModifier(weatherType: weatherManager.weatherType))
                .padding()
            calendarList
            detailedWeatherParametersStack
        }
    }
    
    var calendarList: some View {
        VStack{
            yesterdayTemperatureRow
            ForEach (0..<weatherManager.calendarWeather.daily.time.count){ i in
                CalendarListItem(temperatureMin: weatherManager.calendarWeather.daily.temperature2MMin[i],
                                 temperatureMax: weatherManager.calendarWeather.daily.temperature2MMax[i],
                                 weatherType: weatherManager.getWeatherTypeFromCode(code: weatherManager.calendarWeather.daily.weathercode[i]), date: weatherManager.calendarWeather.daily.time[i])
            }
        }
        .modifier(CardViewModifier(weatherType: weatherManager.weatherType))
        .padding()
    }
    
    
    var detailedWeatherParametersStack: some View {
        VStack(spacing: 8) {
            
            HStack(spacing: 8) {
                Spacer()
                DailyWeatherParameters(title: "Sunrise",
                                       detailedInfo: "7:24",
                                       animationType: "sunrise",
                                       weatherType: weatherManager.weatherType)
                Spacer()
                DailyWeatherParameters(title: "Sunset",
                                       detailedInfo: "16:22",
                                       animationType: "sunset",
                                       weatherType: weatherManager.weatherType)
                Spacer()
            }
            HStack(spacing: 8){
                Spacer()
                DailyWeatherParameters(title: "Humidity",
                                       detailedInfo: "80%",
                                       animationType: "humidity",
                                       weatherType: weatherManager.weatherType)
                Spacer()
                DailyWeatherParameters(title: "Wind speed",
                                       detailedInfo: "16 km/h",
                                       animationType: "windy",
                                       weatherType: weatherManager.weatherType)
                Spacer()
            }
            
        }
        .padding(.horizontal)
    }
}

