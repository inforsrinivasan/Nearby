//
//  LocationListView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct LocationsListView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { _ in
                    NavigationLink(destination: LocationDetailView()) {
                        LocationsListItem()
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
