//
//  SearchBarView.swift
//  WeatherApp
//  Created by Martyna on 08/11/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @State private var placeholderText = "Search for location..."
    
    
    var weatherType: WeatherType
    var body: some View {
        HStack {
            Image.symbol.search
            
            TextField(placeholderText,
                      text: $searchText)
            .placeHolder(Text(placeholderText),
                         show: searchText.isEmpty)
            
            .overlay (
                Image.symbol.xmark
                    .padding()
                    .offset(x: 10)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                       
                    },
                alignment: .trailing
            )
        }
        .padding()
        .font(.headline)
        .foregroundColor(Theme(weatherType: weatherType).cardBackground)
        .background(
            RoundedRectangle(cornerRadius: CGFloat.size.largeCornerRadius)
                .fill(Theme(weatherType: weatherType).backgroundTop)
                .shadow(color: Color.gray
                    .opacity(CGFloat.size.secondaryItemOpacity),
                        radius: CGFloat.size.standardShadowRadius, x:0)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), weatherType: .sun)
    }
}
