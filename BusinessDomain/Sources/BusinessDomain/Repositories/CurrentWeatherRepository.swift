//
//  CurrentWeatherRepository.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import Networking

public protocol CurrentWeatherRepositoring {
  func fetchCurrentWeather(lat: Double, long: Double, unit: WeatherInfoUnit?, lang: String?) async throws -> WeatherReport
}

public final class CurrentWeatherRepository: CurrentWeatherRepositoring {
  private let service: WeatherRestApi

  public init(service: WeatherRestApi) {
    self.service = service
  }

  public func fetchCurrentWeather(lat: Double, long: Double, unit: WeatherInfoUnit? = WeatherInfoUnit.standard, lang: String?) async throws -> WeatherReport {
    let target = CurrentWeatherService.current(lat: lat, lon: long, unit: unit?.rawValue, lang: lang)
    return try await service.request(
      target
    )
  }
}
