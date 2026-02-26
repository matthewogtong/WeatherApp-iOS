//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Matthew Ogtong on 2/26/26.
//

import Foundation

@Observable
class WeatherViewModel {
    var cityName = ""
    var weather: WeatherResponse?
    var errorMessage: String?
    var isLoading = false

    private let weatherService = WeatherService()

    func searchWeather() {
        let city = cityName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !city.isEmpty else { return }

        isLoading = true
        weather = nil
        errorMessage = nil

        Task {
            do {
                let result = try await weatherService.fetchWeather(for: city)
                self.weather = result
            } catch let error as WeatherError {
                self.errorMessage = error.errorDescription
            } catch {
                self.errorMessage = "An unexpected error occurred. Please try again."
            }
            self.isLoading = false
        }
    }
}
