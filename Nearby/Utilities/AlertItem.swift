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

    static let locationRestricted = AlertItem(title: Text("Location Restricted"),
                                            message: Text("Your location is restricted"),
                                            dismissButton: .default(Text("Ok")))

    static let locationDenied = AlertItem(title: Text("Location Denied"),
                                            message: Text("Nearby does not have access to your location. To change that go to Settings -> Nearby -> Location"),
                                            dismissButton: .default(Text("Ok")))

    static let locationDisabled = AlertItem(title: Text("Location Disabled"),
                                            message: Text("YOur device does not have location services enabled. To change that go to Settings -> Privacy -> Location Services"),
                                            dismissButton: .default(Text("Ok")))

    //MARK: ProfileView Errors
    static let invalidProfile = AlertItem(title: Text("Invalid Profile"),
                                            message: Text("All fields are required. Please try again"),
                                            dismissButton: .default(Text("Ok")))

    static let noUserRecord = AlertItem(title: Text("No User Record"),
                                            message: Text("You must login to iCLoud to use Nearby's profile. Please log in from your phone's settings screen"),
                                            dismissButton: .default(Text("Ok")))

    static let createProfileSuccess = AlertItem(title: Text("Profile created successfully!!"),
                                            message: Text("Your profile has been created successfully"),
                                            dismissButton: .default(Text("Ok")))

    static let createProfileFailure = AlertItem(title: Text("Failed to create profile"),
                                            message: Text("Something went wrong. Unable to create profile. Please try again"),
                                            dismissButton: .default(Text("Ok")))

    static let unableToRetrieveProfile = AlertItem(title: Text("Unable to retrieve profile"),
                                            message: Text("We were unable to retrieve profile. Please check your internet connection and try again."),
                                            dismissButton: .default(Text("Ok")))
    
}
