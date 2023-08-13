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
  func fetchCurrentWeatherbyCity(name: String, unit: WeatherInfoUnit?, lang: String?) async throws ->
    WeatherReport
  func fetchCurrentWeatherByCities(ids: [String], unit: WeatherInfoUnit?, lang: String?) async throws ->
    WeatherReportCities
}

public final class CurrentWeatherRepository: CurrentWeatherRepositoring {
  private let service: WeatherRestApi

  public init(service: WeatherRestApi) {
    self.service = service
  }

  public func fetchCurrentWeather(lat: Double, long: Double, unit: WeatherInfoUnit? = WeatherInfoUnit.metric, lang: String?) async throws -> WeatherReport {
    let target = CurrentWeatherService.current(lat: lat, lon: long, unit: unit?.rawValue, lang: lang)
    return try await service.request(
      target
    )
  }

  public func fetchCurrentWeatherbyCity(name: String, unit: WeatherInfoUnit? = .metric, lang: String?) async throws -> WeatherReport {
    let target = CurrentWeatherService.currentyByCity(name: name, unit: unit?.rawValue, lang: lang)
    return try await service.request(target)
  }

  public func fetchCurrentWeatherByCities(ids: [String], unit: WeatherInfoUnit?, lang: String?) async throws -> WeatherReportCities {
    let target = CurrentWeatherService.currentByCities(ids: ids, unit: unit?.rawValue, lang: lang)
    return try await service.request(target)
  }
}
