//
//  View+Extension.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-18.
//

import SwiftUI

extension View {
    func profileNameStyle() -> some View {
        modifier(ProfileNameText())
    }

    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
