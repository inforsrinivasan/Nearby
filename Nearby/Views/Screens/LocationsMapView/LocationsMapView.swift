//
//  LocationMapView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI
import MapKit

struct LocationsMapView: View {

    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationsMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: locationManager.locations) { area in
                MapMarker(
                    coordinate: area.location.coordinate,
                    tint: .brandPrimary)
            }
                .accentColor(.brandSecondary)
                .edgesIgnoringSafeArea(.top)
            VStack {
                LogoView(frameWidth: 125)
                    .shadow(radius: 10)
                Spacer()
            }
        }
        .sheet(isPresented: $viewModel.isShowingOnboardingView,
               onDismiss: {
            viewModel.checkIfLocationServicesIsEnabled()
        }) {
            OnboardingView(isShowingOnboardingView: $viewModel.isShowingOnboardingView)
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            viewModel.runStartupChecks()
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
        }
    }
}

struct LocationsMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsMapView()
    }
}
