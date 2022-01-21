//
//  LocationListView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct LocationsListView: View {

    @State private var locations: [NLocation] = [
        NLocation(record: MockData.location)
    ].compactMap { $0 }
    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationsListItem(location: location)
                    }
                }
            }
            .navigationTitle("Spots")
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}
