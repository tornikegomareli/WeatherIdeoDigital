//
//  WeatherCondition.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

struct WeatherCondition {
  let conditionID: Int
  let category: String
  let description: String
  let iconID: String
}

extension WeatherCondition: Codable {
  enum CodingKeys: String, CodingKey {
    case conditionID = "id"
    case iconID = "icon"
    case description = "description"
    case category = "main"
  }
}
