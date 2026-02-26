//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Matthew Ogtong on 2/26/26.
//

import Foundation

enum WeatherError: LocalizedError {
    case invalidURL
    case invalidResponse
    case cityNotFound
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request."
        case .invalidResponse:
            return "Invalid response from server."
        case .cityNotFound:
            return "City not found. Please check the spelling and try again."
        case .serverError(let code):
            return "Server error (\(code)). Please try again later."
        }
    }
}

class WeatherService {
    private let apiKey: String

    init() {
        guard let key = Bundle.main.infoDictionary?["WeatherAPIKey"] as? String,
              !key.isEmpty,
              key != "YOUR_API_KEY_HERE" else {
            fatalError("Weather API key not configured. Add your key to Config.xcconfig.")
        }
        self.apiKey = key
    }

    func fetchWeather(for city: String) async throws -> WeatherResponse {
        let trimmed = city.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let encodedCity = trimmed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&appid=\(apiKey)&units=imperial") else {
            throw WeatherError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw WeatherError.invalidResponse
        }

        switch httpResponse.statusCode {
        case 200:
            return try JSONDecoder().decode(WeatherResponse.self, from: data)
        case 404:
            throw WeatherError.cityNotFound
        default:
            throw WeatherError.serverError(httpResponse.statusCode)
        }
    }
}
