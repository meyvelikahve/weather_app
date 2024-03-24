//
//  WeatherManager.swift
//  weather_app
//
//  Created by Recep Sevim on 20.03.2024.
//

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=\(Constants.apiKey)&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchCityWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchCurrentWeather(latitude: CLLocationDegrees, longitute: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitute)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String)  {
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weatherModel =  parseJson(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weatherModel)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJson(_ jsonData : Data) -> WeatherModel? {
        do{
            let weatherData = try JSONDecoder().decode(WeatherData.self, from: jsonData)
            let weatherModel = WeatherModel(weatherData: weatherData)
            
            return weatherModel
            
            
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
