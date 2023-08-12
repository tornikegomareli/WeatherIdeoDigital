//
//  WeatherReport.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct WeatherReport: Codable {
  let coordinates: Coordinates
  let weatherConditions: [WeatherCondition]
  let baseStation: String
  let mainWeatherData: WeatherData
  let visibility: Int
  let windInformation: WindInformation
  let cloudCoverage: CloudCoverage
  let timestamp: Int
  let systemInformation: SystemInformation
  let timezoneOffset: Int
  let cityID: Int
  let cityName: String
  let statusCode: Int
}
