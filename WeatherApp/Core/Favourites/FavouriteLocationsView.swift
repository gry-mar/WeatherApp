//
//  FavouriteLocationsView.swift
//  WeatherApp
//
//  Created by Martyna on 08/11/2022.
//

import SwiftUI

struct FavouriteLocationsView: View {
    
    var weatherType: WeatherType
    @StateObject var viewModel = FavouritesViewModel()
    @StateObject var locationManager = LocationManager()
    @State private var searchText: String = ""
    @State private var isMapPresented = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView{
                ScrollView{
                    ZStack{
                        mapAndSavedLocationsStack(width: geometry.size.width, height: geometry.size.height)
                        VStack(spacing: 16){
                            SearchBarView(searchText: $searchText,
                                          weatherType: weatherType)
                            .onChange(of: searchText, perform: { searchText in
                                
                                viewModel.onTextChange(text: searchText)
                                
                            })
                            .padding(8)
                            
                            foundLocationsList
                        }
                    }
                    .sheet(isPresented: $isMapPresented ){
                        AddFromMapView(favouritesViewModel: self.viewModel)
                           // .environmentObject(viewModel)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            Text("Saved locations")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .scrollIndicators(.hidden)
                .background(LinearGradient(colors:[Theme(weatherType: weatherType).backgroundTop,
                                                   Theme(weatherType: weatherType).backgroundBottom],
                                           startPoint: .top,
                                           endPoint: .bottom))
                
            }
            
            .refreshable{
                viewModel.refreshLocations()
            }
            
            
        }
    }
}

struct FavouriteLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteLocationsView(weatherType: .rain)
    }
}

private extension FavouriteLocationsView {
    var chooseFromMapHStack: some View {
       // NavigationLink(destination: AddFromMapView(), isActive: $isMapPresented, label: {
            Button {
                isMapPresented.toggle()
            } label: {
                HStack{
                    Text("Add from map")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                    Image.symbol.map
                        .resizable()
                        .frame(width: CGFloat.size.regularIconFrame,
                               height: CGFloat.size.regularIconFrame)
                        .foregroundColor(.white)
                        .disabled(viewModel.locations.isEmpty ? false : true)
                    Spacer()
                }
                .padding(.leading)
            }
       // })
    }
    
    func mapAndSavedLocationsStack(width: CGFloat, height: CGFloat)->some View {
        
        VStack(spacing: 12){
            chooseFromMapHStack
            List(viewModel.savedLocationsWithWeather, id: \.id) { location in
                SavedLocationCardView(savedLocation: location)
                    .swipeActions{
                        Button(role: .destructive){
                            viewModel.deleteLocation(location: location)
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    .frame(width: 0.9 * width)
                    .listRowBackground(Theme.init(weatherType: weatherType).transparent)
            }
            .frame(minWidth: width, minHeight: height)
            .background(Theme.init(weatherType: weatherType).transparent)
            
            
        }
        .scrollContentBackground(.hidden)
        .padding(.top, 90)
        .blur(radius: viewModel.locations.isEmpty ? 0 : 1)
    }
    
    var foundLocationsList: some View {
        
        ScrollView{
            ForEach(viewModel.locations, id: \.id){ suggestion in
                
                HStack{
                    Button{
                        viewModel.addSavedLocation(latitude: "\(suggestion.latitude)",
                                                   longitude: "\(suggestion.longitude)",
                                                   city: "\(suggestion.name)",
                                                   country: "\(suggestion.country)")
                        viewModel.locations = []
                        searchText = ""
                    } label: {
                        Text("\(suggestion.name), \(suggestion.region), \(suggestion.country)")
                            .foregroundColor(Color.white)
                    }
                    Spacer()
                }
                Divider()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Theme(weatherType: weatherType).backgroundTop)
                    .opacity(0.9)
            )
            
            
        }
        .opacity(viewModel.locations.isEmpty ? 0 : 1)
    }
}
