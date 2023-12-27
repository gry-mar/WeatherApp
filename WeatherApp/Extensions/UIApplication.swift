//
//  UIApplication.swift
//  WeatherApp
//
//  Created by Martyna on 29/11/2022.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
