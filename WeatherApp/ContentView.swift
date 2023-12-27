//
//  ContentView.swift
//  WeatherApp
//
//  Created by Martyna on 02/11/2022.
//

import SwiftUI


struct ContentView: View {
    @StateObject var weatherManager = WeatherManager()
    @State var selectedItem = 2
    var body: some View {
        
        TabView(selection: $selectedItem) {
            FavouriteLocationsView(weatherType: weatherManager.weatherType)
                .tabItem{
                    Image.symbol.list
                }
                .tag(1)
            HomeView()
                .environmentObject(weatherManager)
                .tabItem{
                    Image.symbol.home
                }
                .tag(2)
        }
        .environmentObject(weatherManager)
        .accentColor(Theme(weatherType: weatherManager.weatherType).backgroundTop)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(.blue.opacity(0.1))
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        .task {
            weatherManager.refresh()
            
        }
        //Page Control
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


