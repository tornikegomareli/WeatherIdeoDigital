//
//  WeatherReport.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct WeatherReport {
  let coordinates: Coordinates
  let weatherConditions: [WeatherCondition]
  let mainWeatherData: WeatherData
  let windInformation: WindInformation
  let systemInformation: SystemInformation
  let cityID: Int
  let cityName: String
}

extension WeatherReport: Codable {
  enum CodingKeys: String, CodingKey {
    case coordinates = "coord"
    case weatherConditions = "weather"
    case windInformation = "wind"
    case systemInformation = "sys"
    case mainWeatherData = "main"
    case cityID  = "id"
    case cityName = "name"
  }
}
