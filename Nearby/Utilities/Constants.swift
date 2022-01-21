//
//  COnstants.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import Foundation
import UIKit

enum RecordType {
    static let location = "NLocation"
    static let profile = "NProfile"
}

enum PlaceholderImages {
    static let avatar = UIImage(named: "default-avatar")!
    static let banner = UIImage(named: "default-banner-asset")!
    static let square = UIImage(named: "default-square-asset")!
}

enum ImageDimension {
    case square, banner

    static func getPlaceholder(for dimension: ImageDimension) -> UIImage {
        switch dimension {
        case .square:
            return PlaceholderImages.square
        case .banner:
            return PlaceholderImages.banner
        }
    }
}
