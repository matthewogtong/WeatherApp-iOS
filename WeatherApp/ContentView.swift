//
//  ContentView.swift
//  WeatherApp
//
//  Created by Matthew Ogtong on 2/26/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    TextField("Enter city name", text: $viewModel.cityName)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            viewModel.searchWeather()
                        }

                    Button("Search") {
                        viewModel.searchWeather()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Loading...")
                    Spacer()
                } else if let weather = viewModel.weather {
                    weatherView(weather)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                } else {
                    Spacer()
                }
            }
            .navigationTitle("Weather")
        }
    }

    private func weatherView(_ weather: WeatherResponse) -> some View {
        VStack(spacing: 12) {
            Text(weather.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            if let condition = weather.weather.first {
                Text(condition.description.capitalized)
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }

            Text("\(Int(weather.main.temp))°F")
                .font(.system(size: 64, weight: .thin))

            HStack(spacing: 32) {
                Label("\(weather.main.humidity)%", systemImage: "humidity")
                Label("\(String(format: "%.1f", weather.wind.speed)) mph", systemImage: "wind")
            }
            .font(.title3)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
