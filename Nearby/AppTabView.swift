//
//  AppTabView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            LocationsMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            LocationsListView()
                .tabItem {
                    Label("List", systemImage: "building")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .accentColor(.brandPrimary)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
