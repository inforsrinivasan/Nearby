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
