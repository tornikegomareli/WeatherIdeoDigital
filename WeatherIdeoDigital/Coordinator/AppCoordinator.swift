//
//  AppCoordinator.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//


import Foundation
import XCoordinator
import UIKit
import BusinessDomain

enum AppRoute: Route {
  case application
}

class AppCoordinator: BasicViewCoordinator<AppRoute> {
  init() {
    super.init(rootViewController: MainController(), initialRoute: nil, initialLoadingType: .immediately, prepareTransition: nil)
  }

  deinit {
    print("⬅️🗑 deinit AppCoordinator")
  }

  override func prepareTransition(for route: AppRoute) -> ViewTransition {
    switch route {
    case .application:
      print("👍 present Application")
      if children.contains(where: { $0 is AppMainTabBarCoordinator }) {
        return .none()
      }

      let coordinator = AppMainTabBarCoordinator()
      return .switchTo(coordinator, in: self.rootViewController.view)
    }
  }
}
