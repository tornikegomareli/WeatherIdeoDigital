//
//  WeatherReport.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct WeatherReport {
  public let coordinates: Coordinates
  public let weatherConditions: [WeatherCondition]
  public let mainWeatherData: WeatherData
  public let windInformation: WindInformation
  public let clouds: CloudCoverage
  public let systemInformation: SystemInformation
  public let cityID: Int
  public let cityName: String
}

extension WeatherReport: Codable {
  enum CodingKeys: String, CodingKey {
    case coordinates = "coord"
    case weatherConditions = "weather"
    case windInformation = "wind"
    case systemInformation = "sys"
    case mainWeatherData = "main"
    case clouds = "clouds"
    case cityID  = "id"
    case cityName = "name"
  }
}
