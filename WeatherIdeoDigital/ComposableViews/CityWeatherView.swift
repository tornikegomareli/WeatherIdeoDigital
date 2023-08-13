//
//  CityWeatherView.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 13/08/2023.
//

import UIKit
import SnapKit
import Core
import Kingfisher

class CityWeatherView: UIView, Sendable {
  private lazy var cityNameLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-SemiBold", size: 18)
    view.textAlignment = .center
    view.textColor = .white
    view.numberOfLines = 1
    return view
  }()

  private lazy var wrapperView: UIView = {
    let view = UIView(frame: .zero)
    return view
  }()

  private lazy var temperatureLabel: UILabel = {
    let view = UILabel()
    view.font = UIFont(name: "AdventPro-Bold", size: 18)
    view.textAlignment = .center
    view.textColor = .white
    view.numberOfLines = 1
    return view
  }()

  private var weatherIconImageView: UIImageView = {
    let view = UIImageView(frame: .zero)
    return view
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    layout()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {
    addSubview(wrapperView)
    wrapperView.addSubview(cityNameLabel)
    wrapperView.addSubview(weatherIconImageView)
    wrapperView.addSubview(temperatureLabel)
  }

  private func layout() {
    wrapperView.snp.remakeConstraints { make in
      make.edges.equalToSuperview()
    }

    cityNameLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.centerX.equalToSuperview()
    }

    weatherIconImageView.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(cityNameLabel.snp.bottom).offset(10)
      make.size.equalTo(25)
    }

    temperatureLabel.snp.makeConstraints { make in
      make.top.equalTo(weatherIconImageView.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-10)
    }
  }

  func configure(cityName: String, weatherIcon: String, temperature: Double) {
    cityNameLabel.text = cityName
    let processor =
    DownsamplingImageProcessor(size: weatherIconImageView.bounds.size)
    |> RoundCornerImageProcessor(cornerRadius: 20)
    guard let url = WeatherIconURLBuilder(iconID: weatherIcon).withScale(2).build() else {
      return
    }

    weatherIconImageView.kf.indicatorType = .activity
    weatherIconImageView.kf.setImage(
      with: url
    ) {
      result in
      switch result {
      case .success(let value):
        print(value)
      case .failure(let error):
        print("Job failed: \(error.localizedDescription)")
      }
    }
    temperatureLabel.text = "\(temperature)"
  }
}
