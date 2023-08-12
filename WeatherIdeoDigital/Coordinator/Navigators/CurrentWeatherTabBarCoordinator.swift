//
//  CurrentWeatherTabBarCoordinator.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import UIKit
import XCoordinator
import WeatherUI

enum CurrentWeatherRoute: Route {
  case main
}

class CurrentWeatherTabBarCoordinator: NavigationCoordinator<CurrentWeatherRoute> {
  init() {
    let root = RootNavigationController(navigationBarAppearanceType: .transparent)
    super.init(rootViewController: root, initialRoute: .main)
  }
  
  deinit {
    print("⬅️🗑 deinit CurrentWeatherCoordinator")
  }
  
  override func prepareTransition(for route: CurrentWeatherRoute) -> NavigationTransition {
    switch route {
    case .main:
      let controller = makeViewController(for: route)
      return .set([controller])
    }
    
    func makeViewController(for route: CurrentWeatherRoute) -> UIViewController {
      switch route {
      case .main:
        return ViewController()
      default:
        fatalError("Error has occurred")
      }
    }
  }
}
