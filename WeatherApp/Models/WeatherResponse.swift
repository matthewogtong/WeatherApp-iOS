//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Matthew Ogtong on 2/26/26.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: MainWeather
    let weather: [Weather]
    let wind: Wind
}

struct MainWeather: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Wind: Decodable {
    let speed: Double
}
