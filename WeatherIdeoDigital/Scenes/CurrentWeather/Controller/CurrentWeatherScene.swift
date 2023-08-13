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
import RxSwift
import NotificationBannerSwift
import Kingfisher
import Core

class CurrentWeatherScene: UIViewController {
  @Dependency(\.currentWeatherRepository) var repository
  private let disposeBag = DisposeBag()

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
    view.text = "Sunday 15:15"
    view.textColor = .white
    view.alpha = 0
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
    view.alpha = 0
    return view
  }()

  private lazy var weatherMainStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .fill
    view.distribution = .fill
    view.spacing = 2
    return view
  }()

  private lazy var childWeatherStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.alignment = .fill
    view.distribution = .fill
    view.spacing = 0
    return view
  }()

  private lazy var weatherDescriptionLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Light", size: 20)
    view.textColor = .white
    view.text = "Cloudy"
    view.alpha = 0
    return view
  }()

  private lazy var weatherTempLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Light", size: 50)
    view.textColor = .white
    view.textAlignment = .left
    view.text = "25C"
    view.alpha = 0
    return view
  }()

  private lazy var weatherIconImage: UIImageView = {
    let view = UIImageView(image: UIImage(systemName: "cloud"))
    view.tintColor = .white
    view.alpha = 0
    return view
  }()

  private lazy var weatherInfoStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .horizontal
    view.alignment = .fill
    view.distribution = .fill
    view.spacing = 10
    return view
  }()

  private lazy var sunriseStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fill
    view.spacing = 10
    return view
  }()

  private lazy var sunsriseIconImage: UIImageView = {
    let view = UIImageView(image: UIImage(systemName: "sunrise.fill"))
    view.tintColor = .white
    view.alpha = 0
    return view
  }()

  private lazy var sunriseLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Regular", size: 18)
    view.alpha = 0
    view.textColor = .white
    return view
  }()

  private lazy var windStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fill
    view.spacing = 10
    return view
  }()

  private lazy var windIconImage: UIImageView = {
    let view = UIImageView(image: UIImage(systemName: "wind"))
    view.tintColor = .white
    view.alpha = 0
    return view
  }()

  private lazy var windLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Regular", size: 18)
    view.alpha = 0
    view.textColor = .white
    return view
  }()

  private lazy var umbrellaStackView: UIStackView = {
    let view = UIStackView()
    view.axis = .vertical
    view.alignment = .center
    view.distribution = .fill
    view.spacing = 10
    return view
  }()

  private lazy var umbrellaIconImage: UIImageView = {
    let view = UIImageView(image: UIImage(systemName: "umbrella.fill"))
    view.tintColor = .white
    view.alpha = 0
    return view
  }()

  private lazy var cloudLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Regular", size: 18)
    view.alpha = 0
    view.textColor = .white
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

  private var viewModel: CurrentWeatherViewModelType = CurrentWeatherViewModel()

  // MARK: Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    configureNavigationBar()
    layout()

    locationAnimationView.play()
    bind()
    viewModel.inputs.viewDidLoad()
  }

  private func bind() {
    viewModel.outputs.actions
      .drive(with: self, onNext: { owner, action in
        owner.didReceive(newAction: action)
      })
      .disposed(by: disposeBag)

    segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
  }

  private func didReceive(newAction action: ViewActions) {
    switch action {
    case .idle:
      break
    case .randomBackgroundAnimation(let name):
      startGifAnimation(with: name)
    case .locasionPermissionUpdated(let status):
      if status == .denied || status == .notDetermined || status == .notSupported {
        weatherMainStackView.isHidden = true
        weatherInfoStackView.isHidden = true
        locationStackView.isHidden = true
        segmentControl.isHidden = true

        let banner = FloatingNotificationBanner(title: "Location is \(status)", subtitle: "Open settings, and approve to share location, otherwise you can't use Weather Features", style: .warning)
        banner.haptic = .heavy
        banner.delegate = self
        banner.show(queuePosition: .front)
      } else {
        weatherMainStackView.isHidden = false
        weatherInfoStackView.isHidden = false
        locationStackView.isHidden = false
        viewModel.inputs.fetchCurrentUserLocation()
      }
    case .onCurrentDate(let dateString):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.dateLabel.alpha = 1
        self.dateLabel.text = dateString
      })
    case .onUpdatedCity(let cityName):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.cityNameLabel.alpha = 1
        self.cityNameLabel.text = cityName
      }) { [weak self] isFinished in
        guard let self else {
          return
        }

        if isFinished {
          self.viewModel.inputs.fetchCurrentLocationWeatherData(with: .metric)
        }
      }
    case .onCurrentTemperature(let temp):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.weatherTempLabel.text = "\(temp) ℃"
        self.weatherTempLabel.alpha = 1
      })
    case .onCurrentConditionIcon(let icon):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        let weatherIconURL = WeatherIconURLBuilder(iconID: icon).withScale(2).build()

        if let url = weatherIconURL {
          print("Weather Icon URL: \(url)")
          let processor =
          DownsamplingImageProcessor(size: weatherIconImage.bounds.size)
          |> RoundCornerImageProcessor(cornerRadius: 20)

          weatherIconImage.kf.indicatorType = .activity
          weatherIconImage.kf.setImage(
            with: url,
            options: [
              .processor(processor),
              .scaleFactor(UIScreen.main.scale),
              .transition(.fade(1)),
              .cacheOriginalImage
            ])
          {
            result in
            switch result {
            case .success(let value):
              self.weatherIconImage.alpha = 1
            case .failure(let error):
              print("Job failed: \(error.localizedDescription)")
            }
          }
        } else {
          print("Invalid URL")
        }
      })
    case .onCurrentCondition(let text):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.weatherDescriptionLabel.text = text
        self.weatherDescriptionLabel.alpha = 1
      })
    case .onSunrise(let value):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.sunriseLabel.text = value.fromTimeStampToHumanRedableTime()
        self.sunriseLabel.alpha = 1
        self.sunsriseIconImage.alpha = 1
      })
    case .onWindInfo(let value):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.windLabel.text = String(format: "%0.2f", value) + "M/S"
        self.windLabel.alpha = 1
        self.windIconImage.alpha = 1
      })
    case .onPressure(let value):
      UIView.animate(withDuration: 0.5, animations: { [weak self] in
        guard let self else {
          return
        }

        self.cloudLabel.text = "\(value) %"
        self.cloudLabel.alpha = 1
        self.umbrellaIconImage.alpha = 1
      })
    }
  }


  private func setup() {
    view.insertSubview(gifImageView, at: 0)
    view.addSubview(locationStackView)
    view.addSubview(weatherMainStackView)
    view.addSubview(weatherInfoStackView)

    // Top Left Stack view
    locationStackView.addArrangedSubview(childLocationStackView)

    childLocationStackView.addArrangedSubview(locationAnimationView)
    childLocationStackView.addArrangedSubview(cityNameLabel)
    locationStackView.addArrangedSubview(dateLabel)

    // Middle weather main stats
    weatherMainStackView.addArrangedSubview(childWeatherStackView)
    weatherMainStackView.addArrangedSubview(weatherDescriptionLabel)

    childWeatherStackView.addArrangedSubview(weatherTempLabel)
    childWeatherStackView.addArrangedSubview(weatherIconImage)

    // Weather Info
    weatherInfoStackView.addArrangedSubview(sunriseStackView)
    sunriseStackView.addArrangedSubview(sunsriseIconImage)
    sunriseStackView.addArrangedSubview(sunriseLabel)

    weatherInfoStackView.addArrangedSubview(windStackView)
    windStackView.addArrangedSubview(windIconImage)
    windStackView.addArrangedSubview(windLabel)

    weatherInfoStackView.addArrangedSubview(umbrellaStackView)
    umbrellaStackView.addArrangedSubview(umbrellaIconImage)
    umbrellaStackView.addArrangedSubview(cloudLabel)
  }

  private func layout() {
    locationStackView.snp.remakeConstraints { make in
      make.leading.equalToSuperview().offset(32.0)
      make.top.equalToSuperview().offset(80)
    }

    locationAnimationView.snp.remakeConstraints { make in
      make.size.equalTo(40)
    }

    weatherMainStackView.snp.remakeConstraints { make in
      make.trailing.equalToSuperview().offset(-40)
      make.top.equalToSuperview().offset(160)
    }

    weatherIconImage.snp.remakeConstraints { make in
      make.size.equalTo(40)
    }

    weatherInfoStackView.snp.remakeConstraints { make in
      make.center.equalToSuperview()
    }

    sunsriseIconImage.snp.remakeConstraints { make in
      make.size.equalTo(22)
    }

    windIconImage.snp.remakeConstraints { make in
      make.size.equalTo(22)
    }

    umbrellaIconImage.snp.remakeConstraints { make in
      make.size.equalTo(22)
    }
  }

  private func startGifAnimation(with name: String) {
    gifImageView.animate(withGIFNamed: name, loopBlock:  {})
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

  @objc func segmentedControlValueChanged(_ sender: BetterSegmentedControl) {
    viewModel.inputs.fetchCurrentLocationWeatherData(with: sender.index == 0 ? .metric : .imperial)
  }
}

extension CurrentWeatherScene: NotificationBannerDelegate {
  func notificationBannerWillAppear(_ banner: NotificationBannerSwift.BaseNotificationBanner) {
  }

  func notificationBannerDidAppear(_ banner: NotificationBannerSwift.BaseNotificationBanner) {
  }

  func notificationBannerWillDisappear(_ banner: NotificationBannerSwift.BaseNotificationBanner) {
    if let url = URL(string: UIApplication.openSettingsURLString) {
      UIApplication.shared.open(url)
    }
  }

  func notificationBannerDidDisappear(_ banner: NotificationBannerSwift.BaseNotificationBanner) {
  }
}
