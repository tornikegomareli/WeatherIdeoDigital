//
//  SplashScene.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 13/08/2023.
//

import UIKit
import Lottie
import SnapKit
import Dependencies

final class SplashScene: UIViewController {
  @Dependency(\.appCoordinator) var appCoordinator

  private lazy var animationView: LottieAnimationView = {
    let view = LottieAnimationView(name: "launch.json")
    return view
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setup()
    layout()
    playAnimation()
  }

  private func setup() {
    view.addSubview(animationView)
  }

  private func layout() {
    animationView.snp.remakeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(75.0)
      make.width.equalTo(75.0)
    }
  }

  private func playAnimation() {
    animationView.play { [weak self] finished in
      guard let self else {
        return
      }

      if finished {
        self.appCoordinator.trigger(.application)
      }
    }
  }
}
