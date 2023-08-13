//
//  CurrentWeatherViewModelType.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 13/08/2023.
//

import Foundation
import RxSwift
import RxCocoa
import BusinessDomain
import XCoordinator
import PermissionsKit

extension CurrentWeatherScene {
  enum ViewActions {
    case idle
    case locasionPermissionUpdated(status: Permission.Status)
    case onCurrentDate(dateString: String)
    case onUpdatedCity(cityName: String)
    case randomBackgroundAnimation(name: String)
    case onCurrentTemperature(temp: Int)
    case onCurrentConditionIcon(icon: String)
    case onCurrentCondition(text: String)
    case onSunrise(value: Int)
    case onWindInfo(value: Double)
    case onPressure(value: Int)
    case onCitiesFetch(citeisWeatherData: [WeatherReport])
  }
}

protocol CurrentWeatherViewModelInputs {
  func viewDidLoad()
  func fetchCurrentUserLocation()
  func fetchCurrentLocationWeatherData(with unit: WeatherInfoUnit)
  func fetchCities(with unit: WeatherInfoUnit)
}

protocol CurrentWeatherViewModelOutputs {
  var actions: Driver<CurrentWeatherScene.ViewActions> { get }
}

protocol CurrentWeatherViewModelType {
  var inputs: CurrentWeatherViewModelInputs { get }
  var outputs: CurrentWeatherViewModelOutputs { get }
}

extension CurrentWeatherViewModel: CurrentWeatherViewModelType {
  var inputs: CurrentWeatherViewModelInputs { return self }
  var outputs: CurrentWeatherViewModelOutputs { return self }
}
