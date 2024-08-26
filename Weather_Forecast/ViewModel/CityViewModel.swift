//
//  CityViewModel.swift
//  Weather_Forecast
//
//  Created by Taha Dirican on 25.08.2024.
//

import Foundation
import Combine
import CoreLocation

class CityViewModel: ObservableObject {
    @Published var cities: [City] = []
    private var cancellables = Set<AnyCancellable>()

    
    func fetchCities() {
        guard let url = URL(string: "http://localhost:3000/cities") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [String].self, decoder: JSONDecoder())
            .map { cityNames in
                cityNames.map { City(name: $0) }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching cities: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] cities in
                self?.cities = cities
            })
            .store(in: &cancellables)
    }
}
