//
//  AvatarView.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-18.
//

import SwiftUI

struct AvatarView: View {

    let image: UIImage
    let size: CGFloat

    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: PlaceholderImages.avatar, size: 90)
    }
}
