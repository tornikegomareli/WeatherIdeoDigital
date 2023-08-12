//
//  BuildConfiguration.swift
//
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

/// Enumeration representing different build environments.
/// This is part of a proof-of-concept class used for a technical interview task.
/// In the current implementation, all environments point to the same URL.
/// In a real-world production scenario, this would be adapted to handle different URLs for different environments.
enum Environment: String {
  case debugDevelopment = "Debug Development"
  case releaseDevelopment = "Release Development"
  case debugStaging = "Debug Staging"
  case releaseStaging = "Release Staging"
  case debugProduction = "Debug Production"
  case releaseProduction = "Release Production"
}

/// `BuildConfiguration` class is responsible for managing the build environment.
/// It's used as a proof-of-concept for a technical task and currently supports only one URL.
/// In a production setting, this class would be extended to handle different URLs for different environments.
class BuildConfiguration {
  let environment: Environment
  
  /// The base URL for the API. Currently, all environments use the same URL.
  /// In a production scenario, this would be adapted to return different URLs for different environments.
  var apiBaseURL: URL {
    switch environment {
    case .debugDevelopment, .debugProduction:
      return URL(string: "http://api.openweathermap.org/data/2.5")!
    case .debugStaging, .releaseStaging:
      return URL(string: "http://api.openweathermap.org/data/2.5")!
    case .releaseDevelopment, .releaseProduction:
      return URL(string: "http://api.openweathermap.org/data/2.5")!
    }
  }
  
  /// Initializes the build configuration based on the current bundle.
  /// Defaults to "Debug Production" environment.
  init() {
    guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
      fatalError("Configuration missing for bundle")
    }
    
    environment = Environment(rawValue: "Debug Production")!
  }
}
