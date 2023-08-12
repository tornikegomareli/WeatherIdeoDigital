//
//  MainController.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import Foundation
import UIKit
import RxSwift
import BusinessDomain
import XCoordinator

class MainController: UIViewController {
  private let disposeBag = DisposeBag()
  private let viewModel: MainViewModel = MainViewModel()

  private var current: UIViewController?

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("💥 init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    viewModel.outputs.actions
      .withUnretained(self)
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { _, _ in
//        owner.didReceive(newAction: action)
      })
      .disposed(by: disposeBag)

    viewModel.viewDidLoad()
  }

  private func didReceive(newAction action: MainViewModel.ViewActions) {
  }

  override func becomeFirstResponder() -> Bool {
    return true
  }
}
