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

public struct WeatherData: Codable {
  /// Weather item's temperature values in Kelvin
  public var kelvin: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (temperature, maximumTemperature, minimumTemperature)
    }
  }

  /// Weather item's temperature values in Celsius
  public var celsius: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (temperature.toCelsius(), maximumTemperature.toCelsius(), minimumTemperature.toCelsius())
    }
  }

  /// Weather item's temperature values in Fahrenheit
  public var fahrenheit: (currentTemp: Double, maxTemp: Double, minTemp: Double) {
    get {
      return (celsius.currentTemp.toFahrenheit(), celsius.maxTemp.toFahrenheit(), celsius.minTemp.toFahrenheit())
    }
  }

  public let temperature: Double
  public let minimumTemperature: Double
  public let maximumTemperature: Double

  enum CodingKeys: String, CodingKey {
    case temperature = "temp"
    case minimumTemperature = "temp_min"
    case maximumTemperature = "temp_max"
  }
}
