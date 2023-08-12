//
//  File.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import Networking

public enum AppErrorReason: Equatable {
  case general
  case networking(error: WeatherApiError)

  public var error: Error? {
    switch self {
    case .general:
      return nil
    case .networking(let error):
      return error
    }
  }
}

public struct AppError: Error {
  public let reason: AppErrorReason
  public let code: Int

  public var isNetworkingError: Bool {
    switch reason {
    case .general:
      return false
    case .networking:
      return true
    }
  }

  public init(reason: AppErrorReason, code: Int) {
    self.reason = reason
    self.code = code
  }
}

extension AppError: Equatable { }
