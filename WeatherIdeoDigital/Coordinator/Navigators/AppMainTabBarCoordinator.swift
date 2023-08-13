//
//  AppMainTabBarCoordinator.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import Dependencies
import BusinessDomain
import UIKit
import XCoordinator
import WeatherUI

enum AppMainTabBarRoute: Route {
  case mainCurrentWeather
  case randomThreePlace
  case dismiss
}

class AppMainTabBarCoordinator: TabBarCoordinator<AppMainTabBarRoute> {
  private var currentWeatherRouter: CurrentWeatherTabBarCoordinator
  private var routeHandler: RouteHandler = RouteHandler()

  convenience init() {
    let currentWeatherCoordinator = CurrentWeatherTabBarCoordinator()
    currentWeatherCoordinator.rootViewController.tabBarItem = UITabBarItem(
      title: "Current Weather",
      image: nil,
      tag: 0
    )

    self.init(currentWeatherRouter: currentWeatherCoordinator)
  }

  init(currentWeatherRouter: CurrentWeatherTabBarCoordinator) {
    self.currentWeatherRouter = currentWeatherRouter
    let tabs: [(route: AppMainTabBarRoute, coordinator: any Coordinator)] = [
      (.mainCurrentWeather, currentWeatherRouter)
    ]

    super.init(
      rootViewController: RootTabBarController(),
      tabs: tabs.map(\.coordinator),
      select: currentWeatherRouter
    )

    self.rootViewController.delegate = routeHandler
    self.routeHandler.shouldSelectCallback = { [weak self] tabIndex in
      guard let self, tabs.indices.contains(tabIndex) else {
        return false
      }

      let selectedItem = tabs[tabIndex]

      self.trigger(selectedItem.route)
      return false
    }
  }

  override func prepareTransition(for route: AppMainTabBarRoute) -> TabBarTransition {
    switch route {
    case .mainCurrentWeather:
      return .select(currentWeatherRouter)
    case .dismiss:
      return .dismiss()
    default:
      return .none()
    }
  }
}
