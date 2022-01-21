//
//  NearbyApp.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-14.
//

import SwiftUI

@main
struct NearbyApp: App {

    let locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environmentObject(locationManager)
        }
    }
}
