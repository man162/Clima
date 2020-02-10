//
//  WeatherData.swift
//  Clima
//
//  Created by Manpreet Singh on 2020-02-09.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let timezone, id: Int
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}
