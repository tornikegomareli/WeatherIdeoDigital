//
//  Date+Extension.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation

public extension Date {
  func dayOfWeekAndDate() -> String {
    let dateFormatter = DateFormatter()

    dateFormatter.locale = Locale.current

    dateFormatter.dateFormat = "EEEE"
    let dayOfWeek = dateFormatter.string(from: self)

    dateFormatter.dateFormat = "d MMMM"
    let date = dateFormatter.string(from: self)
    return "\(dayOfWeek) \(date)"
  }
}
