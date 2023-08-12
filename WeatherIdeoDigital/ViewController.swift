//
//  ViewController.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import UIKit
import BusinessDomain
import Dependencies
import Networking

class ViewController: UIViewController {
  @Dependency(\.currentWeatherRepository) var repository
  
  private var currentTask: Task<Void, Error>?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      view.backgroundColor = .white
      fetch()
    }

  func fetch() {
    currentTask = Task.detached(priority: .background) { [weak self] in
      guard let self else {
        return
      }

      do {
        let weatherData = try await repository.fetchCurrentWeather(lat: 41.693630, long: 44.801620, unit: .imperial, lang: nil)
        print(weatherData)
      } catch {
        print(error)
      }
    }
  }
}

