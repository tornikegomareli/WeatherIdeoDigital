//
//  NavigationController.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

/// Base UINavigationController Subclass. recomended to use everywhere
public class RootNavigationController: UINavigationController {
  /// invoked when viewcontroller when controller is dissmied if it was presented
  public var onDismissBlock: (() -> Void)?

  public init(
    rootViewController: UIViewController,
    andDelegate newDelegate: UINavigationControllerDelegate? = nil,
    navigationBarAppearanceType: NavigationBar.AppearanceType = .transparent
  ) {
    super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    viewControllers = [rootViewController]

    delegate = newDelegate
    setup(navigationBarAppearanceType: navigationBarAppearanceType)
  }

  public init(navigationBarAppearanceType: NavigationBar.AppearanceType = .transparent) {
    super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    setup(navigationBarAppearanceType: navigationBarAppearanceType)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  deinit {
    print("⬅️🗑 deinit NavigationController")
  }

  private func setup(navigationBarAppearanceType: NavigationBar.AppearanceType) {
    guard let navBar = navigationBar as? NavigationBar else {
      return
    }

    navBar.set(appearanceType: navigationBarAppearanceType)
  }

  /// Invoked when view controller dissapeared
  /// - Parameter animated: animated or not
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if isBeingDismissed {
      onDismissBlock?()
    }
  }

  /// Loops trough tab bar controller controllers and notifys about navigation
  /// - Parameter newController: controller instance
  private func notifyControllerChange(to newController: UIViewController? = nil, oldController: UIViewController? = nil) {
    let currentViewControllers = viewControllers

    let newTopController = newController != nil ? newController : visibleViewController
    for _ in currentViewControllers {
      let topController = visibleViewController
      if let topConsumerViewController = topController as? ConsumesNavigationChangeEvents {
        topConsumerViewController.applicationWillNavigate(to: newTopController, previously: oldController)
      }
    }
  }

  /// UINavigationController presentation override
  /// - Parameters:
  ///   - viewControllerToPresent: viewcontroller to present
  ///   - flag: animated or not
  ///   - completion: completion callback
  open override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    notifyControllerChange(to: viewControllerToPresent, oldController: visibleViewController)
    super.present(viewControllerToPresent, animated: flag, completion: completion)
  }

  public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    notifyControllerChange(to: viewController, oldController: visibleViewController)
    super.pushViewController(viewController, animated: animated)
  }

  public override func popViewController(animated: Bool) -> UIViewController? {
    let controller = super.popViewController(animated: animated)
    if let coordinator = transitionCoordinator {
      if coordinator.isInteractive {
        coordinator.notifyWhenInteractionChanges({ context in
          if context.isCancelled {
            return
          }
          let fromViewController = context.viewController(forKey: UITransitionContextViewControllerKey.from)
          let topViewController = context.viewController(forKey: UITransitionContextViewControllerKey.to)
          self.notifyControllerChange(to: topViewController, oldController: fromViewController)
        })
      } else if !coordinator.isCancelled {
        notifyControllerChange(to: visibleViewController, oldController: controller)
      }
    }
    return controller
  }
}

extension RootNavigationController: ProvidesNavigationChangeEvents {
  public func onPresentedDissmiss(_ dismissed: UIViewController?) {
    notifyControllerChange(oldController: dismissed)
  }
}
