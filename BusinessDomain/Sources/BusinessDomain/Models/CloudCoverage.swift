//
//  CloudCoverage.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

public struct CloudCoverage {
  public let coveragePercentage: Int
}

extension CloudCoverage: Codable {
  enum CodingKeys: String, CodingKey {
    case coveragePercentage = "all"
  }
}
