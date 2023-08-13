//
//  TransperentCardView.swift
//  WeatherIdeoDigital
//
//  Created by Tornike on 13/08/2023.
//

import UIKit

class TransperentCardView: UIView {
  private let gradientLayer = CAGradientLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  private func setupView() {
    // Gradient
    gradientLayer.colors = [
      UIColor.black.withAlphaComponent(0.7).cgColor,
      UIColor.darkGray.withAlphaComponent(0.5).cgColor
    ]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
    layer.insertSublayer(gradientLayer, at: 0)

    // Corners
    layer.cornerRadius = 10
    clipsToBounds = true

    // Shadow
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOffset = CGSize(width: 0, height: 4)
    layer.shadowRadius = 8
    layer.shadowOpacity = 0.2
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
}
