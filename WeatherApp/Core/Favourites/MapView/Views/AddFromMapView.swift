//
//  AddFromMapView.swift
//  WeatherApp
//
//  Created by Martyna on 06/12/2022.
//

import SwiftUI
import MapKit

struct AddFromMapView: View {
    @Environment(\.dismiss) var dismiss
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.107883,
                                       longitude: 17.038538),
        span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
    @ObservedObject var favouritesViewModel: FavouritesViewModel
    @StateObject var viewModel = AddFromMapViewModel()
    @State var isPresented = false
    
    
    var body: some View {
        //NavigationView{
        ZStack {
            Map(coordinateRegion: $region)
                .onTapGesture{ location in
                    print("location \(location)")
                    
                }
            Circle()
                .fill(.red)
                .opacity(0.5)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .trailing){
                Spacer()
                HStack {
                    Spacer()
                }
                Button {
                    Task{
                       let _ = await favouritesViewModel.searchLocationFromCoordinates(latitude: "\(region.center.latitude)", longitude: "\(region.center.longitude)")
                        dismiss()
                        
                    }
                    
                    
                    
                } label: {
                    ZStack {
                        Circle()
                            .fill(.blue)
                            .frame(width: 64)
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                            .bold()
                    }
                }
            }
            
            .padding(12)
           
        }
    }
    
        
}

struct AddFromMapView_Previews: PreviewProvider {
    static var previews: some View {
        AddFromMapView(favouritesViewModel: FavouritesViewModel())
    }
}
