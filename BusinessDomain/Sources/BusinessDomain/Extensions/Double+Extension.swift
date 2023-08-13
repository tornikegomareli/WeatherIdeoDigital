//
//  Double+Extension.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

internal let kKelvinZeroInCelsius = 273.15
internal let kFahrenheitZeroInKelvin = -459.67

public extension Double {
  /// Converts the current value from Kelvin to Celsius.
  func toCelsius() -> Double {
    return self - kKelvinZeroInCelsius
  }

  /// Converts the current value from Celsius to Fahrenheit.
  func toFahrenheit() -> Double {
    return self * 9 / 5 + 32
  }

  func asString(style: DateComponentsFormatter.UnitsStyle) -> String {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
    formatter.unitsStyle = style
    return formatter.string(from: self) ?? ""
  }
}
