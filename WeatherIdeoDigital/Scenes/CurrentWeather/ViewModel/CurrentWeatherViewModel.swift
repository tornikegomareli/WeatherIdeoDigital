//
//  CurrentWeatherViewModel.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 13/08/2023.
//

import Foundation
import RxSwift
import RxCocoa
import BusinessDomain
import Networking
import XCoordinator
import Core
import Dependencies
import PermissionsKit
import LocationAlwaysPermission
import LocationWhenInUsePermission
import CoreLocation

class CurrentWeatherViewModel: BaseViewModel, CurrentWeatherViewModelInputs, CurrentWeatherViewModelOutputs {
  let actions: Driver<CurrentWeatherScene.ViewActions>

  /// data or ui related actions dispatched by viewmodel
  private let actionsSubject: PublishSubject<CurrentWeatherScene.ViewActions> = PublishSubject<CurrentWeatherScene.ViewActions>()

  @Dependency(\.appCoordinator) var coordinator
  @Dependency(\.currentWeatherRepository) var repository

  private var locationManager: CLLocationManager?
  private var currentTask: Task<Void, Error>?
  private var activeBackgroundGifs: [String] = [
    "day2",
    "day3",
    "day5",
    "heavyrain",
    "nigh3",
    "night4",
    "pixelnightrain",
    "day",
    "night",
    "night2"
  ]

  // MARK: Lifecycle

  override init() {
    actions = actionsSubject
      .asDriver(onErrorJustReturn: .idle)

    super.init()
  }

  private func getCurrentCityBasedOnLocation(completion: @escaping (String) -> Void) {
    guard let locationManager = locationManager, let location = locationManager.location else {
      return
    }

    location.fetchCityAndCountry { [weak self] city, _, _ in
      guard let self else {
        return
      }

      guard let city = city else {
        return
      }

      completion(city)
    }
  }

  private func getRandomGifName() -> String {
    return activeBackgroundGifs.randomElement() ?? ""
  }

  func viewDidLoad() {
    actionsSubject.onNext(.randomBackgroundAnimation(name: getRandomGifName()))
    Permission.locationWhenInUse.request { [weak self] in
      guard let self else {
        return
      }

      self.actionsSubject.onNext(.locasionPermissionUpdated(status: Permission.locationWhenInUse.status))
    }
  }

  private func sendUpdateActions(_ self: CurrentWeatherViewModel, _ weatherData: WeatherReport) {
    self.actionsSubject.onNext(.onCurrentTemperature(temp: Int(weatherData.mainWeatherData.temperature)))
    self.actionsSubject.onNext(.onCurrentConditionIcon(icon: weatherData.weatherConditions.first?.iconID ?? ""))
    self.actionsSubject.onNext(.onCurrentCondition(text: weatherData.weatherConditions.first?.description ?? ""))
    self.actionsSubject.onNext(.onWindInfo(value: weatherData.windInformation.speed))
    self.actionsSubject.onNext(.onSunrise(value: weatherData.systemInformation.sunriseTimestamp))
    self.actionsSubject.onNext(.onPressure(value: weatherData.clouds.coveragePercentage))
  }

  func fetchCurrentLocationWeatherData(with unit: WeatherInfoUnit = .metric) {
    getCurrentCityBasedOnLocation { [weak self] city in
      guard let self else {
        return
      }

      self.currentTask = Task.detached(priority: .background) { [weak self] in
        guard let self else {
          return
        }

        do {
          let weatherData = try await repository.fetchCurrentWeatherbyCity(name: city, unit: unit, lang: nil)
          sendUpdateActions(self, weatherData)
          print(weatherData)
        } catch {
          print(error)
        }
      }
    }
  }
  
  func fetchCurrentUserLocation() {
    if CLLocationManager.locationServicesEnabled() {
      locationManager = CLLocationManager()
      locationManager?.delegate = self
      locationManager?.desiredAccuracy = kCLLocationAccuracyBest
      locationManager?.startUpdatingLocation()
    }
  }

  deinit {
    currentTask?.cancel()
    currentTask = nil
  }
}

extension CurrentWeatherViewModel: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last! as CLLocation
    location.fetchCityAndCountry { [weak self] city, country, error in
      guard let self else {
        return
      }

      guard let city = city else {
        return
      }

      let dayOfWeekAndDate = Date().dayOfWeekAndDate()
      self.actionsSubject.onNext(.onCurrentDate(dateString: dayOfWeekAndDate))
      self.actionsSubject.onNext(.onUpdatedCity(cityName: city))
    }
  }
}
