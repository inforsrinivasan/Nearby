//
//  LocationsMapViewModel.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import MapKit

final class LocationsMapViewModel: ObservableObject {

    @Published var alertItem: AlertItem?
    @Published var locations: [NLocation] = []
    @Published var region = MKCoordinateRegion(
                                    center: .init(latitude: 59.3293,
                                                  longitude: 18.0686),
                                    span: .init(latitudeDelta: 0.01,
                                                longitudeDelta: 0.01)
                                )

    func getLocations() {
        CloudKitManager.getLocations { [self] result in
            switch result {
            case .success(let locations):
                self.locations = locations
            case .failure(_):
                alertItem = AlertContext.unableToGetLocations
            }
        }
    }

}
