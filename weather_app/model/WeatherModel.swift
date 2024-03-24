//
//  WeatherModel.swift
//  weather_app
//
//  Created by Recep Sevim on 20.03.2024.
//

import Foundation


struct WeatherModel {
    let weatherData : WeatherData
    
    var tempatureString : String {
        return String(format: "%.1f", weatherData.main.temp)
    }
    
    var conditionName : String {
        switch weatherData.weather[0].id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    
}
