//
//  WeatherViewModel.swift
//  Weather_Forecast
//
//  Created by Taha Dirican on 25.08.2024.
//

import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?

    func fetchWeather(for city: String) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=acf3d5e6efbe4d668f3131845242508&q=\(city)") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.weather = decodedData
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
}
