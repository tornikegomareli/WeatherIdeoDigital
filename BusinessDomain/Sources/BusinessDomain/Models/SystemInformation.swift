//
//  SystemInformation.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct SystemInformation {
  public let type: Int?
  public let systemID: Int?
  public let countryISOCode: String
  public let sunriseTimestamp: Int
  public let sunsetTimestamp: Int
}

extension SystemInformation: Codable {
  enum CodingKeys: String, CodingKey {
    case type
    case systemID = "id"
    case countryISOCode = "country"
    case sunriseTimestamp = "sunrise"
    case sunsetTimestamp = "sunset"
  }
}
