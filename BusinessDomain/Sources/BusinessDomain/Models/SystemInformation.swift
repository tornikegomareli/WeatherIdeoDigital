//
//  SystemInformation.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

struct SystemInformation: Codable {
  let type: Int
  let systemID: Int
  let countryISOCode: String
  let sunriseTimestamp: Int
  let sunsetTimestamp: Int
}
