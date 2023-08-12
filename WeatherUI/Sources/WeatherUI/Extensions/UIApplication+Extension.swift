//
//  File.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

public extension UIApplication {
  var mainWindow: UIWindow? {
    return UIApplication
      .shared
      .connectedScenes
      .compactMap { ($0 as? UIWindowScene)?.keyWindow }
      .first
  }
}
