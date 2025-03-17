//
//  WeatherViewModel.swift
//  APIWeather
//
//  Created by Rawan on 17/09/1446 AH.
//

import Foundation

class WeatherManager: ObservableObject {
    @Published var weather: WeatherData? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    let apiKey = "fe94986738d87abec2f6c587bad9d336" // my OpenWeather API key
    
    func fetchWeather(city: String) {
        guard !city.isEmpty else { return } // no empty city
        //start loading
        isLoading = true
        errorMessage = nil
        //the url for each city name with my apikey
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"
        //handling errors
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false //stop loading when request is complete
                //handling errors
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                //make sure we got data
                guard let data = data else {
                    self.errorMessage = "No data received"
                    return
                }
                //decoding jason
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    self.weather = decodedData
                } catch {
                    self.errorMessage = "Failed to decode data"
                }
            }
        }.resume()
    }
}

