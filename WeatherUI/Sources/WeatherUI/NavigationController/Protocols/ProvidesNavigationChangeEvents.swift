//
//  ProvidesNavigationChangeEvents.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

public protocol ProvidesNavigationChangeEvents where Self: UIViewController {
  func onPresentedDissmiss(_ dismissed: UIViewController?)
}
