//
//  LocationsMapViewModel.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import MapKit

final class LocationsMapViewModel: ObservableObject {

    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(
                                    center: .init(latitude: 59.3293,
                                                  longitude: 18.0686),
                                    span: .init(latitudeDelta: 0.07,
                                                longitudeDelta: 0.07)
                                )

    func getLocations(for locationManager: LocationManager) {
        CloudKitManager.getLocations { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
        }
    }

}
