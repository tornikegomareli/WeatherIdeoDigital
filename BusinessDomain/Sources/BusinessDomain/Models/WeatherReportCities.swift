//
//  File.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation

public struct WeatherReportCities {
  public var count: Int
  public var listOfWeather: [WeatherReport]
}

extension WeatherReportCities: Codable {
  enum CodingKeys: String, CodingKey {
    case count = "cnt"
    case listOfWeather = "list"
  }
}
