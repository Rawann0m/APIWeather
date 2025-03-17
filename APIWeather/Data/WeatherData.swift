//
//  Untitled.swift
//  APIWeather
//
//  Created by Rawan on 17/09/1446 AH.
//

import Foundation
//the struct of the data
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
