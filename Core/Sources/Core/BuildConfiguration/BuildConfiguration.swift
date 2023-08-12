//
//  BuildConfiguration.swift
//
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import Dependencies

/// Enumeration representing different build environments.
/// This is part of a proof-of-concept class used for a technical interview task.
/// In the current implementation, all environments point to the same URL.
/// In a real-world production scenario, this would be adapted to handle different URLs for different environments.
public enum AppEnvironment: String {
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
public class BuildConfiguration {
  var appEnvironment: AppEnvironment
  
  /// The base URL for the API. Currently, all environments use the same URL.
  /// In a production scenario, this would be adapted to return different URLs for different environments.
  public var apiBaseURL: URL {
    switch appEnvironment {
    case .debugDevelopment, .debugProduction:
      return URL(string: "http://api.openweathermap.org/data/")!
    case .debugStaging, .releaseStaging:
      return URL(string: "http://api.openweathermap.org/data/")!
    case .releaseDevelopment, .releaseProduction:
      return URL(string: "http://api.openweathermap.org/data/")!
    }
  }
  
  /// Initializes the build configuration based on the current bundle.
  /// Defaults to "Debug Production" environment.
  public init(environment: AppEnvironment) {
//    guard let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String else {
//      fatalError("Configuration missing for bundle")
//    }
    appEnvironment = environment
  }
}
