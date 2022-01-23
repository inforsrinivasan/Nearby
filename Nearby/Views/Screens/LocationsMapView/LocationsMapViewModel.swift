//
//  LocationsMapViewModel.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import MapKit

final class LocationsMapViewModel: NSObject, ObservableObject {

    @Published var isShowingOnboardingView: Bool = false
    @Published var alertItem: AlertItem?
    @Published var region = MKCoordinateRegion(
                                    center: .init(latitude: 59.3293,
                                                  longitude: 18.0686),
                                    span: .init(latitudeDelta: 0.07,
                                                longitudeDelta: 0.07)
                                )

    var deviceLocationManager: CLLocationManager?
    let kHasSeenOnboardingView = "hasSeenOnboardingView"

    var hasSeenOnboardingView: Bool {
        return UserDefaults.standard.bool(forKey: kHasSeenOnboardingView) // defaults to false if not available
    }

    func runStartupChecks() {
        if !hasSeenOnboardingView {
            isShowingOnboardingView = true
            UserDefaults.standard.set(true, forKey: kHasSeenOnboardingView)
        } else {
            checkIfLocationServicesIsEnabled()
        }
    }

    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager?.delegate = self
            deviceLocationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }

    private func checkLocationAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }

        switch deviceLocationManager.authorizationStatus {

        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }

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

extension LocationsMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
