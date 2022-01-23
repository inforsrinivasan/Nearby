//
//  OnboardingView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-22.
//

import SwiftUI

struct OnboardingView: View {

    @Binding var isShowingOnboardingView: Bool

    var body: some View {
        VStack(spacing: 32) {
            HStack  {
                Spacer()
                Button {
                    isShowingOnboardingView = false
                } label: {
                    XDismissButton()
                }
                .padding()
            }

            Spacer()

            LogoView(frameWidth: 250)
                .padding(.bottom)

            VStack(alignment: .leading, spacing: 26) {
                OnboardingInfoView(imageName: "building.2.crop.circle",
                                   title: "Resturant Locations",
                                   description: "Find places to dine around the convention center")
                OnboardingInfoView(imageName: "checkmark.circle",
                                   title: "Check In",
                                   description: "Let your friends know where you are")
                OnboardingInfoView(imageName: "person.2.circle",
                                   title: "Find Friends",
                                   description: "See where your friends are and join them")
            }
            .padding(.horizontal, 30)
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isShowingOnboardingView: .constant(false))
    }
}

struct OnboardingInfoView: View {

    var imageName: String
    var title: String
    var description: String

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.brandPrimary)
            VStack(alignment: .leading, spacing: 6) {
                Text(title).bold()
                Text(description)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)
            }
        }
    }
}
