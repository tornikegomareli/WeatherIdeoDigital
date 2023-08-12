//
//  RouteHandler.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

class RouteHandler: NSObject {
  public typealias ShouldSelectItemCallback = ((_ tabIndex: Int) -> Bool)

  var shouldSelectCallback: ShouldSelectItemCallback?
}

extension RouteHandler: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    guard let index = tabBarController.viewControllers?.firstIndex(of: viewController) else {
      return true
    }

    return shouldSelectCallback?(index) ?? true
  }
}
