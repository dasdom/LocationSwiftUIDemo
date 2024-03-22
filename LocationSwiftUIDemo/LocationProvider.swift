//  Created by Dominik Hauser on 14/03/2021.
//  Copyright © 2021 dasdom. All rights reserved.
//

import UIKit
import CoreLocation
import Combine

enum LocationProviderError: Error {
  case noLocation
}

class LocationProvider: NSObject, ObservableObject {

  private let locationManager: CLLocationManager
  @Published var location: CLLocation?
  @Published var wrongAuthorization: Bool = false
  private var cancellables = Set<AnyCancellable>()

  init(locationManager: CLLocationManager = CLLocationManager()) {

    self.locationManager = locationManager

    super.init()

    locationManager.requestWhenInUseAuthorization()
    locationManager.delegate = self
  }

  func start() {
    locationManager.startUpdatingLocation()
    locationManager.startUpdatingHeading()
  }

  func stop() {
    locationManager.stopUpdatingLocation()
    locationManager.stopUpdatingHeading()
  }

  func set(headingOrientation: CLDeviceOrientation) {
    locationManager.headingOrientation = headingOrientation
  }
}

extension LocationProvider: CLLocationManagerDelegate {
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

    switch manager.authorizationStatus {
      case .authorizedWhenInUse:
        wrongAuthorization = false
        start()
        print("authorizedWhenInUse")
      default:
        wrongAuthorization = true
        print("No authorization")
    }
  }

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    location = locations.last
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error \(error)")
  }
}
