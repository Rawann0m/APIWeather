//
//  WeatherView.swift
//  APIWeather
//
//  Created by Rawan on 17/09/1446 AH.
//
import SwiftUI

struct WeatherView: View {
    @State private var cityName: String = ""
    @StateObject var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack{
            //background
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //  city input
                TextField("Enter city name", text: $cityName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                
                if weatherManager.isLoading {
                    ProgressView("Loading...")
                } else if let weather = weatherManager.weather {
                    ZStack {
                        //rectangle on the backround so the words can appear better
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 300, height: 150)
                            .shadow(radius: 10)
                        //here is a vstack for the city and the temp and the description so it appear above eachother
                        VStack(alignment: .center, spacing: 10) {
                            Text("\(weather.name)")
                                .font(.largeTitle)
                                .bold()
                            Text("\(weather.main.temp, specifier: "%.1f")°C")
                                .font(.title)
                            Text("\(weather.weather.first?.description.capitalized ?? "N/A")")
                                .font(.headline)
                        }
                        .padding()
                    }
                    //handling errors
                } else if let errorMessage = weatherManager.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                Spacer()
                //refresh button
                Button(action: {
                    weatherManager.fetchWeather(city: cityName)
                }) {
                    Text("Refresh")
                        .padding()
                        .background(Color.cyan.opacity(0.5))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
            .padding()
            
            .onAppear {
                weatherManager.fetchWeather(city: cityName)
            }
        }
    }
}

#Preview {
    WeatherView()
}

