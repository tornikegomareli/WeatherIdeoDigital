//
//  NavigationBar.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import UIKit

public class NavigationBar: UINavigationBar {
  public enum AppearanceType {
    case transparent
    case standard
    case bottomSheet
  }

  public private(set) var appearanceType: AppearanceType = .transparent

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupNavBar()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override func awakeFromNib() {
    super.awakeFromNib()
    setupNavBar()
  }

  func setupNavBar() {
    set(appearanceType: appearanceType)
  }

  public func set(appearanceType newType: AppearanceType) {
    appearanceType = newType
    buildAppearance(of: appearanceType)
  }

  private func buildAppearance(of type: AppearanceType) {
    isTranslucent = true
    let appearance = UINavigationBarAppearance()

    if type == .transparent {
      appearance.configureWithTransparentBackground()
    } else {
      appearance.configureWithDefaultBackground()
    }

    appearance.shadowColor = setShadowColor(for: type)
    appearance.backgroundColor = setBackgroundColor(for: type)

    appearance.titleTextAttributes = [
      .foregroundColor: setTitleForegroundColor(for: type),
      .font: setTitleFont(for: type)
    ]
    standardAppearance = appearance
    scrollEdgeAppearance = appearance
  }

  public override func pushItem(_ item: UINavigationItem, animated: Bool) {
    super.pushItem(item, animated: animated)
    let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    item.backBarButtonItem = backBarButtton
  }

  // MARK: Private Implementation

  private func setShadowColor(for type: AppearanceType) -> UIColor {
    switch type {
    case .standard, .bottomSheet:
      return UIColor.gray
    case .transparent:
      return UIColor.clear
    }
  }

  private func setBackgroundColor(for type: AppearanceType) -> UIColor? {
    switch type {
    case .standard, .bottomSheet:
      return UIColor.gray
    case .transparent:
      return nil
    }
  }

  private func setTitleForegroundColor(for type: AppearanceType) -> UIColor {
    switch type {
    case .standard, .bottomSheet:
      return UIColor.white
    case .transparent:
      return UIColor.green
    }
  }

  private func setTitleFont(for type: AppearanceType) -> UIFont {
    return .systemFont(ofSize: 12)
  }
}
