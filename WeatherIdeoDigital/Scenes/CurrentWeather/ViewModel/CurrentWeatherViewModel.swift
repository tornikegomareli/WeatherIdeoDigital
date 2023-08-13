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

  private var locationManager: CLLocationManager
  private var currentTask: Task<Void, Error>?
  private var geocoder = CLGeocoder()
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
    locationManager = CLLocationManager()

    super.init()
    locationManager.delegate = self
  }

  private func getCurrentCityBasedOnLocation(completion: @escaping (String) -> Void) {
    guard let location = locationManager.location else {
      return
    }

    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      guard let placemark = placemarks?.first, error == nil else {
        print("Error fetching city name:", error ?? "Unknown error")
        return
      }

      let cityName = placemark.administrativeArea ?? "City name not found"
      completion(cityName)
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

  func fetchCities(with unit: WeatherInfoUnit) {
    self.currentTask = Task.detached(priority: .background) { [weak self] in
      guard let self else {
        return
      }

      // Milan, New York, Telaviv
      let preConditionedCities = ["3173435", "2988507", "293397"]
      do {
        let weatherDataList = try await repository.fetchCurrentWeatherByCities(
          ids: preConditionedCities,
          unit: unit,
          lang: nil
        )

        self.actionsSubject.onNext(.onCitiesFetch(citeisWeatherData: weatherDataList.listOfWeather))
      } catch {
        print(error)
      }
    }
  }

  func redrawBackgroundAnimation() {
    actionsSubject.onNext(.randomBackgroundAnimation(name: getRandomGifName()))
  }

  deinit {
    currentTask?.cancel()
    currentTask = nil
  }
}


extension CurrentWeatherViewModel: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last! as CLLocation

    geocoder.reverseGeocodeLocation(location) { placemarks, error in
      guard let placemark = placemarks?.first, error == nil else {
        print("Error fetching city name:", error ?? "Unknown error")
        return
      }

      let cityName = placemark.administrativeArea ?? "City name not found"

      let dayOfWeekAndDate = Date().dayOfWeekAndDate()
      self.actionsSubject.onNext(.onCurrentDate(dateString: dayOfWeekAndDate))
      self.actionsSubject.onNext(.onUpdatedCity(cityName: cityName))
    }
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    let status = manager.authorizationStatus
    if status == .authorizedWhenInUse || status == .authorizedAlways {
      manager.startUpdatingLocation()
    }
  }
}
