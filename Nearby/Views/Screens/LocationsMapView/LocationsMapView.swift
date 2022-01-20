//
//  LocationMapView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI
import MapKit

struct LocationsMapView: View {

    @StateObject private var viewModel = LocationsMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region)
                .ignoresSafeArea()
            VStack {
                LogoView()
                    .shadow(radius: 10)
                Spacer()
            }
        }
        .alert(item: $viewModel.alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            viewModel.getLocations()
        }
    }
}

struct LocationsMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsMapView()
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(width: 150)
    }
}
