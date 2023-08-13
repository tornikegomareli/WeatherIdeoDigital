//
//  WeatherIconURLBuilder.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation

public final class WeatherIconURLBuilder {
  private let baseURL = "https://openweathermap.org/img/wn/"
  private var iconID: String
  private var scale: Int = 2

  public init(iconID: String) {
    self.iconID = iconID
  }

  public func withScale(_ scale: Int) -> WeatherIconURLBuilder {
    self.scale = scale
    return self
  }

  public func build() -> URL? {
    let urlString = "\(baseURL)\(iconID)@\(scale)x.png"
    return URL(string: urlString)
  }
}
