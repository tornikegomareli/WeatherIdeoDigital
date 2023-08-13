//
//  CLLocation+Extension.swift
//  
//
//  Created by Tornike on 13/08/2023.
//

import Foundation
import UIKit
import MapKit

public extension CLLocation {
  func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
    CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
  }
}
