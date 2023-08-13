//
//  MainViewModel.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import Foundation
import RxSwift
import Dependencies

/// MainViewModel: ViewModel for MainController
class MainViewModel: NSObject, MainViewModelInputs, MainViewModelOutputs {
  private let disposeBag = DisposeBag()

  /// data or ui related actions dispatched by viewmodel
  let actions: Observable<ViewActions>

  @Dependency(\.appCoordinator) var coordinator

  /// data or ui related actions dispatched by viewmodel
  private let actionsSubject: PublishSubject<ViewActions> = PublishSubject<ViewActions>()

  override init() {
    actions = actionsSubject.asObserver()
    super.init()
  }

  func viewDidLoad() {
    presentApplication()
  }

  func presentApplication() {
    coordinator.trigger(.splashScene)
  }
}
