//
//  CustomNavigationChangeEvents.swift
//  
//
//  Created by Tornike on 12/08/2023.
//

import UIKit

public protocol ConsumesNavigationChangeEvents where Self: UIViewController {
  func applicationWillNavigate(to controller: UIViewController?, previously: UIViewController?)
}
