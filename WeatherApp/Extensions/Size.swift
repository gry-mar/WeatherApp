//
//  Size.swift
//  WeatherApp
//
//  Created by Martyna on 08/11/2022.
//

import Foundation


extension CGFloat{
    static let size = StandardSize()
}


struct StandardSize {
    let mediumCornerRadius = CGFloat(24)
    let largeCornerRadius = CGFloat(36)
    
    let mediumPadding = CGFloat(24)
    
    let smallPadding = CGFloat(8)
    let regularPadding = CGFloat(16)
    let largePadding = CGFloat(32)
    
    let secondaryItemOpacity = CGFloat(0.7)
    
    let regularIconFrame = CGFloat(44)
    let mediumIconFrame = CGFloat(56)
    
    let standardShadowRadius = CGFloat(3)
    let standadShadowYAxis = CGFloat(3)
}
