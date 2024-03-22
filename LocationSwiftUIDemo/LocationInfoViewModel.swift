//  Created by Dominik Hauser on 22.03.24.
//  
//


import Foundation
import Combine

class LocationInfoViewModel: ObservableObject {
  let locationProvider: LocationProvider
  var token: AnyCancellable?
  @Published var coordinateLocation: String = "None"

  init() {
    locationProvider = LocationProvider()

    token = locationProvider.$location.sink { [weak self] location in
      if let location {
        self?.coordinateLocation = String(format: "%.5lf, %.5lf", location.coordinate.latitude, location.coordinate.longitude)
      }
    }
  }
}
