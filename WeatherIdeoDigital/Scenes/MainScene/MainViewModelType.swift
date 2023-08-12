//
//  MainViewModelType.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import RxSwift
import BusinessDomain

extension MainViewModel {
  /// Enum for `MainViewModel.ViewActions`
  enum ViewActions {
  }
}

protocol MainViewModelInputs {
}

protocol MainViewModelOutputs {
  var actions: Observable<MainViewModel.ViewActions> { get }
}

protocol MainViewModelType {
  var inputs: MainViewModelInputs { get }
  var outputs: MainViewModelOutputs { get }
}

extension MainViewModel: MainViewModelType {
  var inputs: MainViewModelInputs { return self }
  var outputs: MainViewModelOutputs { return self }
}
