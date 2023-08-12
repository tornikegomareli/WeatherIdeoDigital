//
//  File.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

extension UIDevice {
  /// Returns `true` if the device has a notch
  var hasNotch: Bool {
    guard let window = UIApplication.shared.mainWindow else {
      return false
    }

    if window.windowScene?.interfaceOrientation.isPortrait == true {
      return window.safeAreaInsets.bottom > .zero
    } else {
      return window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0
    }
  }
}
