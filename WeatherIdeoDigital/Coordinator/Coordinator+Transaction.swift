//
//  Coordinator+Transaction.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import XCoordinator
import UIKit

extension Transition {
  static func switchTo(_ presentable: Presentable, in container: Container) -> Transition {
    Transition(presentables: [presentable], animationInUse: nil) { rootViewController, options, completion in
      rootViewController.switchTo(presentable.viewController, in: container, with: options) {
        presentable.presented(from: rootViewController)
        completion?()
      }
    }
  }
}

public extension UIViewController {
  func switchTo(_ viewController: UIViewController, in container: Container, with options: TransitionOptions, completion: PresentationHandler?) {
    viewController.willMove(toParent: container.viewController)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    container.view.addSubview(viewController.view)
    container.viewController.addChild(viewController)

    // swiftlint:disable force_unwrapping
    NSLayoutConstraint.activate([
      NSLayoutConstraint(
        item: container.view!, attribute: .leading, relatedBy: .equal,
        toItem: viewController.view, attribute: .leading, multiplier: 1, constant: 0
      ),
      NSLayoutConstraint(
        item: container.view!, attribute: .trailing, relatedBy: .equal,
        toItem: viewController.view, attribute: .trailing, multiplier: 1, constant: 0
      ),
      NSLayoutConstraint(
        item: container.view!, attribute: .top, relatedBy: .equal,
        toItem: viewController.view, attribute: .top, multiplier: 1, constant: 0
      ),
      NSLayoutConstraint(
        item: container.view!, attribute: .bottom, relatedBy: .equal,
        toItem: viewController.view, attribute: .bottom, multiplier: 1, constant: 0
      )
    ])

    let controllersToDelete: [UIViewController] = container.viewController.children.filter({ item -> Bool in
      return viewController != item
    })

    if controllersToDelete.isEmpty {
      viewController.didMove(toParent: container.viewController)
      completion?()
      return
    }

    for item in controllersToDelete {
      item.willMove(toParent: nil)
      item.view.removeFromSuperview()
      item.removeFromParent()
    }

    viewController.didMove(toParent: container.viewController)
    completion?()
  }
}
