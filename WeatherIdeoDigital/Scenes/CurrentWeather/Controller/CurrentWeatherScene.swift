//
//  CurrentWeatherScene.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 12/08/2023.
//

import UIKit
import BusinessDomain
import Dependencies
import Networking
import Gifu
import BetterSegmentedControl
import Lottie

class CurrentWeatherScene: UIViewController {
  @Dependency(\.currentWeatherRepository) var repository

  // MARK: Views
  private lazy var locationStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .fill
    view.distribution = .fill
    view.spacing = 5
    return view
  }()

  private lazy var dateLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Light", size: 18)
    view.textAlignment = .left
    view.numberOfLines = 1
    view.text = "Monday 2:45"
    view.textColor = .white
    return view
  }()

  private lazy var childLocationStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.alignment = .center
    view.distribution = .fill
    view.spacing = 5
    return view
  }()

  private lazy var locationAnimationView: LottieAnimationView = {
    let view = LottieAnimationView(name: "locate.json")
    return view
  }()

  private lazy var cityNameLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-SemiBold", size: 29)
    view.textAlignment = .center
    view.textColor = .white
    view.text = "Tbilisi"
    return view
  }()

  private lazy var gifImageView: GIFImageView = {
    let imageView = GIFImageView(frame: view.bounds)
    return imageView
  }()

  private lazy var segmentControl: BetterSegmentedControl = {
    let view = BetterSegmentedControl(
      frame: .zero,
      segments: LabelSegment.segments(
        withTitles: ["℃", "℉"],
        normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!,
        normalTextColor: .lightGray,
        selectedFont: UIFont(name: "HelveticaNeue-Bold",
                             size: 14.0)!,
        selectedTextColor: .white),
      index: 0,
      options: [.backgroundColor(.clear),
                .indicatorViewBackgroundColor(.clear)
      ]
    )

    return view
  }()

  private var currentTask: Task<Void, Error>?
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    startGifAnimation()
    configureNavigationBar()
    layout()
    locationAnimationView.play()
  }

  private func setup() {
    view.insertSubview(gifImageView, at: 0)
    view.addSubview(locationStackView)

    locationStackView.addArrangedSubview(childLocationStackView)

    childLocationStackView.addArrangedSubview(locationAnimationView)
    childLocationStackView.addArrangedSubview(cityNameLabel)
    locationStackView.addArrangedSubview(dateLabel)
  }

  private func layout() {
    locationStackView.snp.remakeConstraints { make in
      make.leading.equalToSuperview().offset(32.0)
      make.top.equalToSuperview().offset(80)
    }

    locationAnimationView.snp.remakeConstraints { make in
      make.size.equalTo(40)
    }
  }

  private func startGifAnimation() {
    gifImageView.animate(withGIFNamed: "nigh3", loopBlock:  {})
  }

  private func configureNavigationBar() {
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    navigationController?.view.backgroundColor = .clear
    navigationController?.hidesBarsOnSwipe = true
    self.navigationController?.navigationBar.addSubview(segmentControl)

    segmentControl.snp.remakeConstraints { make in
      make.height.equalToSuperview()
      make.width.equalToSuperview().multipliedBy(0.2)
      make.center.equalToSuperview()
    }
  }

  func fetch() {
    currentTask = Task.detached(priority: .background) { [weak self] in
      guard let self else {
        return
      }

      do {
        let weatherData = try await repository.fetchCurrentWeather(lat: 41.693630, long: 44.801620, unit: .imperial, lang: nil)
        print(weatherData)
      } catch {
        print(error)
      }
    }
  }
}

