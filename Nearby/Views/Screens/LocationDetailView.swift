//
//  LocationDetailView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-15.
//

import SwiftUI

struct LocationDetailView: View {

    let location: NLocation

    let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

    var body: some View {
            VStack(spacing: 16) {
                BannerImageView(image: location.createBannerImage())
                HStack {
                    AddressView(address: location.address)
                    Spacer()
                }
                .padding(.horizontal)

                DescriptionName(text: location.description)

                ZStack {
                    Capsule()
                        .frame(height: 80)
                        .foregroundColor(Color(.secondarySystemBackground))
                    HStack(spacing: 20) {
                        Button {

                        } label: {
                            LocationActionButton(
                                color: .brandPrimary,
                                imageName: "location.fill")
                        }
                        Link(destination: URL(string: location.websiteURL)!) {
                            LocationActionButton(
                                color: .brandPrimary,
                                imageName: "network")
                        }
                        Button {

                        } label: {
                            LocationActionButton(
                                color: .brandPrimary,
                                imageName: "phone.fill")
                        }
                        Button {

                        } label: {
                            LocationActionButton(
                                color: .brandPrimary,
                                imageName: "person.fill.checkmark")
                        }
                    }
                }
                .padding(.horizontal)

                Text("Who's Here?")
                    .bold()
                    .font(.title2)

                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<9) { index in
                            FirstNameAvatarView(firstName: "Srini \(index)")
                        }
                    }
                }

                Spacer()
            }
            .navigationTitle(location.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(location: NLocation(record: MockData.location)!)
        }
    }
}

struct LocationActionButton: View {

    var color: Color
    var imageName: String

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: 60, height: 60)

            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 22, height: 22)
        }
    }
}

struct FirstNameAvatarView: View {

    let firstName: String

    var body: some View {
        VStack {
            AvatarView(size: 64)
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}

struct BannerImageView: View {

    let image: UIImage

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(height: 120)
    }
}

struct AddressView: View {

    let address: String

    var body: some View {
        Label(address,
              systemImage: "mappin.and.ellipse")
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct DescriptionName: View {

    let text: String

    var body: some View {
        Text(text)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
            .padding(.horizontal)
    }
}
