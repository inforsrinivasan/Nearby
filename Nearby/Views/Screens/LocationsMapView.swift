//
//  LocationMapView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI
import MapKit

struct LocationsMapView: View {

    @State private var region = MKCoordinateRegion(
                                    center: .init(latitude: 59.3293,
                                                  longitude: 18.0686),
                                    span: .init(latitudeDelta: 0.01,
                                                longitudeDelta: 0.01)
                                )
    @State private var alertItem: AlertItem?
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea()
            VStack {
                LogoView()
                    .shadow(radius: 10)
                Spacer()
            }
        }
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        })
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                case .success(let locations):
                    print(locations)
                case .failure(_):
                    alertItem = AlertContext.unableToGetLocations
                }
            }
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
