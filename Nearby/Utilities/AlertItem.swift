//
//  AlertItem.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import SwiftUI

struct AlertItem: Identifiable {

    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {

    //MARK: MapView Errors
    static let unableToGetLocations = AlertItem(title: Text("Locations Error"),
                                            message: Text("Unable to retrieve locations. Please try again later."),
                                            dismissButton: .default(Text("Ok")))
    
}
