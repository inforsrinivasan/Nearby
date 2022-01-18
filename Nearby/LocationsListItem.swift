//
//  LocationsListItem.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-18.
//

import SwiftUI

struct LocationsListItem: View {
    var body: some View {
        HStack {
            Image("default-square-asset")
                .resizable()
                .scaledToFit()
                .frame(width: 80)
                .clipShape(Circle())
                .padding(.vertical, 8)

            VStack(alignment: .leading) {
                Text("Location Namesdfsdfsdfsdf dsfsdf")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)

                HStack {
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                    AvatarView(size: 35)
                }
            }
            .padding(.leading)
        }
    }
}

struct LocationsListItem_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListItem()
    }
}
