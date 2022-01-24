//
//  UIIMage+Extension.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-24.
//

import CloudKit
import UIKit

extension UIImage {
    func convertToCKAsset() -> CKAsset? {
        guard let url = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first else {
            return nil
        }
        let fileURL = url.appendingPathComponent("selectedAvatarImage")
        guard let imageData = jpegData(compressionQuality: 0.25) else { return nil }
        do {
            try imageData.write(to: fileURL)
            return CKAsset(fileURL: fileURL)
        } catch {
            return nil
        }
    }
}
