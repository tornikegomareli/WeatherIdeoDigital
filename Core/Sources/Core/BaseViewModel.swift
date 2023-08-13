//
//  BaseViewModel.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation

open class BaseViewModel: NSObject {
  func cleanup() { }

  deinit {
    cleanup()
    print("⬅️🗑 deinit \(String(describing: type(of: self)))")
  }
}
