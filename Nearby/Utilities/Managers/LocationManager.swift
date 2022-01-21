//
//  LocationManager.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-21.
//

import CoreLocation

final class LocationManager: ObservableObject {
    @Published var locations: [NLocation] = []
}
