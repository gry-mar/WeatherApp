//
//  String.swift
//  WeatherApp
//
//  Created by Martyna on 23/11/2022.
//

import Foundation


extension String {
    
    
    func removeUpToChar(char: String) -> String{
        if let index = (self.range(of: char)?.upperBound)
        {
            return String(self.suffix(from: index))
        }
        return self
    }
    
}

