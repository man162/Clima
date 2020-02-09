//
//  WeatherDataModel.swift
//  Clima
//
//  Created by Manpreet Singh on 2020-02-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData {

    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=29adba096f607f72fa2a604f157c8463&units=metric"

    func fetchData(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }

    func performRequest(urlString: String) {
        // 1. create a url
        if let url = URL(string: urlString) {

            // 2. create urlSession
            let request = URLSession(configuration: .default)

            // 3. create data task
            let task = request.dataTask(with: url) { (data, urlResponse, error) in
                if let error = error {
                    print(error)
                    return
                }

                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!)
                }

            }

            // 4. start the task
            task.resume()
        }
    }

}
