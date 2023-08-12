//
//  Coordinates.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

struct Coordinates {
  let longitude: Double
  let latitude: Double
}

extension Coordinates: Codable {
  enum CodingKeys: String, CodingKey {
    case longitude = "lon"
    case latitude = "lat"
  }
}
