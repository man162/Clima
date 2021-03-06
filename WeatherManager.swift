//
//  WeatherDataModel.swift
//  Clima
//
//  Created by Manpreet Singh on 2020-02-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=29adba096f607f72fa2a604f157c8463&units=metric"

    var delegate: WeatherManagerDelegate?

    func fetchData(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func fetchData(lat: Double, long: Double) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(long)"
        performRequest(with: urlString)
    }

    func performRequest(with urlString: String) {
        // 1. create a url
        if let url = URL(string: urlString) {

            // 2. create urlSession
            let request = URLSession(configuration: .default)

            // 3. create data task
            let task = request.dataTask(with: url) { (data, urlResponse, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weatherModel = self.parseJSONData(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weatherModel)
                    }
                }
            }
            // 4. start the task
            task.resume()
        }
    }

    func parseJSONData(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name

            let weather = WeatherModel(temperature: temp, cityName: cityName, conditionId: id)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
