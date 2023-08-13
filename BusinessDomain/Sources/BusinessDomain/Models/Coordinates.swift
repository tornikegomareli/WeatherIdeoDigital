//
//  Coordinates.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct Coordinates {
  public let longitude: Double
  public let latitude: Double
}

extension Coordinates: Codable {
  enum CodingKeys: String, CodingKey {
    case longitude = "lon"
    case latitude = "lat"
  }
}
