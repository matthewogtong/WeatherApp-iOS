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
                        .autocorrectionDisabled()
                        .onSubmit {
                            viewModel.searchWeather()
                        }

                    Button {
                        viewModel.searchWeather()
                    } label: {
                        Image(systemName: "magnifyingglass")
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.cityName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    Spacer()
                    ProgressView("Fetching weather...")
                    Spacer()
                } else if let weather = viewModel.weather {
                    weatherView(weather)
                    Spacer()
                } else if let error = viewModel.errorMessage {
                    Spacer()
                    ContentUnavailableView {
                        Label("Error", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(error)
                    }
                    Spacer()
                } else {
                    Spacer()
                    ContentUnavailableView {
                        Label("Search for a City", systemImage: "magnifyingglass")
                    } description: {
                        Text("Enter a city name above to see the current weather.")
                    }
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
                AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(condition.icon)@2x.png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }

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
