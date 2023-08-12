//
//  SystemInformation.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

struct SystemInformation {
  let type: Int
  let systemID: Int
  let countryISOCode: String
  let sunriseTimestamp: Int
  let sunsetTimestamp: Int
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
