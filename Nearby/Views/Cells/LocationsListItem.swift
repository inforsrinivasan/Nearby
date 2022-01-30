//
//  LocationsListItem.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-18.
//

import SwiftUI

struct LocationsListItem: View {

    let location: NLocation

    var body: some View {
        HStack {
            Image(uiImage: location.createSquareImage())
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)

            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    AvatarView(image: PlaceholderImages.avatar, size: 35)
                    AvatarView(image: PlaceholderImages.avatar, size: 35)
                    AvatarView(image: PlaceholderImages.avatar, size: 35)
                    AvatarView(image: PlaceholderImages.avatar, size: 35)
                    AvatarView(image: PlaceholderImages.avatar, size: 35)
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationsListItem_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListItem(location: NLocation(record: MockData.location)!)
    }
}
