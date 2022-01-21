//
//  CKAsset+Extension.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-21.
//

import CloudKit
import UIKit

extension CKAsset {
    func toUIImage(in dimension: ImageDimension) -> UIImage {
        let placeholder = ImageDimension.getPlaceholder(for: dimension)

        guard let fileURL = fileURL else { return placeholder}
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data) ?? placeholder
        } catch {
            return placeholder
        }
    }
}
