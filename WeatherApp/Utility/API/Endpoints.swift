//
//  Endpoints.swift
//  WeatherApp
//
//  Created by Martyna on 14/11/2022.
//

import Foundation


enum Endpoint{
    case coordinatesFromLocation(location: String)
    case currentData(latitude: String, longitude: String)
    case locationFromCoordinates(latitude: String, longitude: String)
    case hourlyWeather(latitude: String, longitude: String, currentDate: String)
    case calendarCompact(latitude: String, longitude: String)
    case searchCity(city: String)
    case temperatureMap
}

extension Endpoint {
    var key: String {
        guard let filePath = Bundle.main.path(forResource: "WeatherAppInfo", ofType: "plist") else {
              fatalError("Couldn't find file 'WeatherAppInfo.plist'.")
            }
        let plist = NSDictionary(contentsOfFile: filePath)
        switch self {
        case .searchCity:
            guard let value = plist?.object(forKey: "API_KEY_SEARCH") as? String else {
                  fatalError("Couldn't find key 'API_KEY_SEARCH' in 'WeatherAppInfo.plist'.")
                }
                return value
        default:
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                  fatalError("Couldn't find key 'API_KEY' in 'WeatherAppInfo.plist'.")
                }
                return value
        }
        
    }
    var host: String {
        switch self {
        case .coordinatesFromLocation, .currentData, .locationFromCoordinates:
            return "api.openweathermap.org"
        case .hourlyWeather, .calendarCompact:
            return "api.open-meteo.com"
        case .searchCity:
            return "api.positionstack.com"
        case .temperatureMap:
            return "tile.openweathermap.org"
        }
    }
    var path: String {
        switch self {
        case .coordinatesFromLocation:
            return "/geo/1.0/direct"
        case.currentData:
            return "/data/2.5/weather"
        case .locationFromCoordinates:
            return "/geo/1.0/reverse"
        case .hourlyWeather, .calendarCompact:
            return "/v1/forecast"
        case .searchCity:
            return "/v1/forward"
        case .temperatureMap:
            return "/map/temp_new/0/0/0.png"
        }
    }
    var queryItems: [String: String]? {
        switch self {
        case .coordinatesFromLocation(let location):
            return ["q":"\(location)", "limit":"1", "appid": key]
        case .currentData(let latitude, let longitude):
            return ["lat":"\(latitude)", "lon":"\(longitude)", "appid": key]
        case .locationFromCoordinates(let latitude, let longitude):
            return ["lat":"\(latitude)", "lon":"\(longitude)", "limit":"1", "appid": key]
        case .hourlyWeather(let latitude, let longitude, let currentDate):
            return ["latitude":"\(latitude)", "longitude":"\(longitude)",
                    "hourly":"temperature_2m", "start_date":"\(currentDate)",
                    "end_date":"\(currentDate)"]
            case .calendarCompact(let latitude, let longitude):
            return ["latitude":"\(latitude)", "longitude":"\(longitude)",
                    "daily":"weathercode,temperature_2m_max,temperature_2m_min",
                    "timezone":"auto"]
        case .searchCity(let city):
            return ["query" : city, "access_key": key]
        case .temperatureMap:
            return ["appid": key]
            
        }
    }
    
    var schemeString: String{
        switch self {
        case .searchCity:
            return "http"
        default:
            return "https"
        }
    }
}

extension Endpoint{
    var url: URL? {
        var urlComponent = URLComponents()
        
        urlComponent.scheme = schemeString
        urlComponent.host = host
        urlComponent.path = path
        var requestQueryItems = [URLQueryItem]()
        queryItems?.forEach{ item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        }
        urlComponent.queryItems = requestQueryItems
        return urlComponent.url
    }
}
