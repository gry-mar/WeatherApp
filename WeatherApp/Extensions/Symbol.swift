//
//  Symbol.swift
//  WeatherApp
//
//  Created by Martyna on 04/11/2022.
//

import Foundation
import SwiftUI


extension Image {
    static let symbol = Symbol()
}


struct Symbol {
    let map = Image(systemName: "map")
    let list = Image(systemName: "list.bullet")
    let search = Image(systemName: "magnifyingglass")
    let pin = Image(systemName: "mappin.and.ellipse")
    let xmark = Image(systemName: "xmark.circle.fill")
    let home = Image(systemName: "house")
    
}
