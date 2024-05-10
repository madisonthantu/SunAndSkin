//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Madison Thantu on 8/25/22.
//
//  Client API code obtained from - https://betterprogramming.pub/simple-weather-app-with-swiftui-ac41200a9d4d


import Foundation
import CoreLocation
import SwiftUI

// CLLocationManagerDelegate - The object that you use to start and stop the delivery of location-related events to your app
// NSObject - Defines all things that are shared between all classes that extend from it: NSObject is the root class of most Objective-C class hierarchies. Through NSObject, objects inherit a basic interface to the runtime system and the ability to behave as Objective-C objects
final class WeatherAPIClient: NSObject, CLLocationManagerDelegate, ObservableObject {
    // Declaring VAR currentWeather - optional. If WeatherValue is valid, then assign this value. Otherwise assign nil.
    @Published var location: CLLocationCoordinate2D?
    @Published var currentWeather: Weather?
    // Unless otherwise specified, dates and times requested and returned by Tomorrow.io APIs are represented in ISO 8601 format, which can be parsed by many libraries and languages - https://docs.tomorrow.io/reference/api-formats
    private let dateFormatter = ISO8601DateFormatter()
    
    init(location: CLLocationCoordinate2D) {
        super.init()
        self.location = location
        Task { await fetchWeather() }
    }

    func fetchWeather() async {
        let url = URL(string: "https://api.tomorrow.io/v4")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "apikey", value: "6dPA9GtGUnpDyZYXRLxVL5GXKX280hpC"),
        ]
        
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10

//        let (data, response) = try await URLSession.shared.data(for: request)
//        print(String(decoding: data, as: UTF8.self))
//        
//        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location!.latitude),\(location!.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey={$YOUR_KEY}") else {
//            return
//        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
//            let (data, _) = try await URLSession.shared.data(from: url)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
                let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
                let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                    DispatchQueue.main.async { [weak self] in
                       self?.currentWeather = Weather(temperature: Int(weatherValue.temperature),
                                                      weatherCode: weatherCode)
                    }
            }

        } catch {
            // handle the error
        }
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        Task { await fetchWeather() }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        // handle the error
//    }
}

