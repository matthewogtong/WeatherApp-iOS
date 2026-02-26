# WeatherApp

A simple iOS weather app that lets users search for a city and view current weather conditions using the OpenWeatherMap API.

## Features

- Search weather by city name
- Displays temperature (Fahrenheit), weather condition, icon, humidity, and wind speed
- Error handling for invalid cities and network issues

## Setup

1. Clone the repository
2. Open `WeatherApp.xcodeproj` in Xcode
3. Build and run on a simulator or device

The API key is stored in `Config.xcconfig` and loaded at build time via `Info.plist`. In a production app, this file would be added to `.gitignore` to keep the key out of version control.

## Architecture

The app follows the **MVVM** pattern with SwiftUI:

- **Models** — `WeatherResponse` and related structs decode the OpenWeatherMap JSON response
- **Services** — `WeatherService` handles API calls using async/await and URLSession
- **ViewModels** — `WeatherViewModel` manages UI state and coordinates between the view and service
- **Views** — `ContentView` provides the search interface and displays weather results

## Requirements

- Xcode 26+
- iOS 26+
