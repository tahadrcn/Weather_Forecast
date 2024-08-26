//
//  ContentView.swift
//  Weather_Forecast
//
//  Created by Taha Dirican on 25.08.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var weatherVM = WeatherViewModel()
    @StateObject var cityVM = CityViewModel()
    @StateObject var MyLocation = LocationManagerViewModel()
    @State private var selectedCity: City? = nil
    
    var body: some View {
        VStack{
            Text("Weather Forecast")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                .padding(.top,120)
            Spacer()
            HStack{
                Picker("Please choose a city", selection: $selectedCity) {
                    ForEach(cityVM.cities, id: \.self) { city in
                        Text(city.name).tag(city as City?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .background(RoundedRectangle(cornerRadius: 15).fill(Color.black))
                .onChange(of: selectedCity) { newCity in
                    if let city = newCity {
                        weatherVM.fetchWeather(for: city.name)
                    }
                }
                
                VStack{
                    Image("mylocation")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .onTapGesture {
                            selectedCity?.name = MyLocation.city
                        }
                        Text("My Location")
                }
                .padding(.leading)
            }
            
            if let weather = weatherVM.weather {
                Text("Location: \(weather.location.name), \(weather.location.country)")
                    .font(.headline)
                    .padding() // Metin etrafında boşluk
                    .background(Color.yellow) // Arka plan rengi
                    .cornerRadius(10) // Köşeleri yuvarlama
                Text("Temperature: \(Int(weather.current.temp_c))°C")
                    .font(.title2)
                    .foregroundColor(.black) // Mavi renk
                Text("Condition: \(weather.current.condition.text)")
                    .font(.title2)
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                if let iconURL = URL(string: "https:\(weather.current.condition.icon)") {
                                       AsyncImage(url: iconURL) { image in
                                           image.resizable()
                                               .frame(width: 100, height: 100)
                                       } placeholder: {
                                           ProgressView() // Yükleniyor göstergesi
                                       }
                                   }
            }
            Spacer()
        }
        .onAppear {
            cityVM.fetchCities()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Ekran boyutunda çerçeve
        .background(Color.accentColor) // Arka plan rengi
        .edgesIgnoringSafeArea(.all) // Güvenli alanları göz ardı et
    }
}

#Preview {
    ContentView()
}
