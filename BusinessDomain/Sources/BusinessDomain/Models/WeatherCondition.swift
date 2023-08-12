//
//  WeatherCondition.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

struct WeatherCondition: Codable {
  let conditionID: Int
  let category: String
  let description: String
  let iconID: String
}
