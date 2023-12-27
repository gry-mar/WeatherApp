//
//  CalendarViewModel.swift
//  WeatherApp
//
//  Created by Martyna on 29/11/2022.
//

import Foundation


class CalendarViewModel: ObservableObject {
    
    
    func getWeekDay(stringDate: String) -> String{
        let format = DateFormatter()
        format.dateFormat = "EEE"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: stringDate)!
        return format.string(from: date)
    }
}
