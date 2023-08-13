//
//  WeatherCondition.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct WeatherCondition {
  public let conditionID: Int
  public let category: String
  public let description: String
  public let iconID: String
}

extension WeatherCondition: Codable {
  enum CodingKeys: String, CodingKey {
    case conditionID = "id"
    case iconID = "icon"
    case description = "description"
    case category = "main"
  }
}
