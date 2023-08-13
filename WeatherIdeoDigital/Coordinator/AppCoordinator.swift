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
  case splashScene
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
    case .splashScene:
      if children.contains(where: { $0 is AppMainTabBarCoordinator }) {
        return .none()
      }

      print("👍 present splash")
      let controller = SplashScene()

      if let appTabCoordinator = children.first(where: { $0 is AppMainTabBarCoordinator })?.router(for: AppMainTabBarRoute.dismiss) {
        return .multiple(.trigger(.dismiss, on: appTabCoordinator), .switchTo(controller, in: rootViewController.view))
      }

      return .switchTo(controller, in: rootViewController.view)
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
