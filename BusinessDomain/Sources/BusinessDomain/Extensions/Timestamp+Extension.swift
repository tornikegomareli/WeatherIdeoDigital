//
//  File.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation

public extension Int {
  func fromTimeStampToHumanRedableTime() -> String {
    let timeStamp: TimeInterval = TimeInterval(self)
    let date = Date(timeIntervalSince1970: timeStamp)

    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .medium
    dateFormatter.locale = Locale.current

    return dateFormatter.string(from: date)
  }
}
