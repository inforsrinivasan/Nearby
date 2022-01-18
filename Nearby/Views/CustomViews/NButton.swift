//
//  NButton.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-18.
//

import SwiftUI

struct NButton: View {

    let title: String

    var body: some View {
        Text(title)
            .bold()
            .frame(width: 280, height: 44)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}

struct NButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NButton(title: "Text Button")
        }
        .environment(\.colorScheme, .dark)
    }
}
