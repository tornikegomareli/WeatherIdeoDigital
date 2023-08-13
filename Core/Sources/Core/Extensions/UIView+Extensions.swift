//
//  UIView+Extensions.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import UIKit

public enum CornerRadiusType {
  case fixed(corners: CACornerMask, value: CGFloat)
  case circle
  case pill
  case none
}

public extension CACornerMask {
  static var allCorners: Self = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
  static var onlyRightCorners: Self = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
  static var onlyLeftCorners: Self = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
  static var onlyTopCorners: Self = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
  static var onlyBottomCorners: Self = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
}

public extension UIView {
  func apply(cornerRadius: CornerRadiusType) {
    switch cornerRadius {
    case .fixed(let corners, let value):
      makeRoundedCorners(corners, withRadius: value)
    case .circle:
      makeRoundedCorners(.allCorners, withRadius: bounds.size.width / 2.0)
    case .pill:
      makePillCorners()
    case .none:
      clipsToBounds = false
      layer.cornerRadius = 0
      layer.maskedCorners = []
    }
  }

  func makeRoundedCorners(_ corners: CACornerMask, withRadius radius: CGFloat = 8.0, clipsToBounds: Bool = true) {
    self.clipsToBounds = clipsToBounds
    layer.cornerRadius = radius
    layer.maskedCorners = corners
  }

  func makePillCorners() {
    let radius = bounds.size.height > bounds.size.width
    ? bounds.size.width / 2.0
    : bounds.size.height / 2.0
    makeRoundedCorners(.allCorners, withRadius: radius)
  }
}
