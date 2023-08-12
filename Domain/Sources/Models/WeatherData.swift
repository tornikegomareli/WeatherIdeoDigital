//
//  WeatherData.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

extension WeatherData: CustomStringConvertible {
  public var description: String {
    return """
            WeatherData(
            K: current=\(self.kelvin.currentTemp), max=\(self.kelvin.maxTemp), min=\(self.kelvin.minTemp),
            °С: current=\(self.celsius.currentTemp), max=\(self.celsius.maxTemp), min=\(self.celsius.minTemp),
            °F: current=\(self.fahrenheit.currentTemp), max=\(self.fahrenheit.maxTemp), min=\(self.fahrenheit.minTemp)
            )
            """
  }
}

struct WeatherData: Codable {
  /// Weather item's temperature values in Kelvin
  public var kelvin: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (temp, temp_max, temp_min)
    }
  }

  /// Weather item's temperature values in Celsius
  public var celsius: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (toCelsius(kelvin: temp), toCelsius(kelvin: temp_max), toCelsius(kelvin: temp_min))
    }
  }

  /// Weather item's temperature values in Fahrenheit
  public var fahrenheit: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (toFahrenheit(celsius: celsius.currentTemp), toFahrenheit(celsius: celsius.maxTemp), toFahrenheit(celsius: celsius.minTemp))
    }
  }

  let temperature: Double
  let feelsLikeTemperature: Double
  let minimumTemperature: Double
  let maximumTemperature: Double
  let atmosphericPressure: Int
  let humidityPercentage: Int
  let seaLevelPressure: Int
  let groundLevelPressure: Int

  enum CodingKeys: String, CodingKey {
    case temperature = "temp"
    case feelsLikeTemperature = "feels_like"
    case minimumTemperature = "temp_min"
    case maximumTemperature = "temp_max"
    case atmosphericPressure = "pressure"
    case humidityPercentage = "humidity"
    case seaLevelPressure = "sea_level"
    case groundLevelPressure = "grnd_level"
  }
}
