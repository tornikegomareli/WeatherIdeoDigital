//
//  RootTabBarController.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

public class RootTabBarController: UITabBarController {
  public init(viewControllers: [UIViewController] = []) {
    print("➡️ init TabBarController")
    super.init(nibName: nil, bundle: nil)
    self.viewControllers = viewControllers

    tabBar.isTranslucent = true
    let _: UITabBarAppearance = .init(idiom: .phone)
  }

  public override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)

    for item in self.viewControllers ?? [] {
      if UIDevice.current.hasNotch {
        item.tabBarItem.imageInsets = UIEdgeInsets(top: 2.0, left: 0, bottom: -2.0, right: 0)
      } else {
        item.tabBarItem.imageInsets = UIEdgeInsets(top: -2.0, left: 0.0, bottom: 2.0, right: 0.0)
      }
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
  }

  deinit {
    print("⬅️🗑 deinit TabBarController")
  }

  @available(*, unavailable)
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
