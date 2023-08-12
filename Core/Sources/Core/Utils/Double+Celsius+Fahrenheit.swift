//
//  Double+Celsius+Fahrenheit.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation

internal let kKelvinZeroInCelsius = 273.15
internal let kFahrenheitZeroInKelvin = -459.67

extension Double {
  func toCelsius() -> Double {
    return self - kKelvinZeroInCelsius
  }

  func toFahrenheit() -> Double {
    return self * 9 / 5 + 32
  }
}
