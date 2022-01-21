//
//  NLocation.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-19.
//

import CloudKit
import UIKit

struct NLocation: Identifiable {

    static let kName = "name"
    static let kDescription = "description"
    static let kBannerAsset = "bannerAsset"
    static let kSquareAsset = "squareAsset"
    static let kAddress = "address"
    static let kWebsiteURL = "websiteURL"
    static let kPhoneNumber = "phoneNumber"
    static let kLocation = "location"


    let id: CKRecord.ID
    let name: String
    let description: String
    let squareAsset: CKAsset?
    let bannerAsset: CKAsset?
    let address: String
    let location: CLLocation
    let websiteURL: String
    let phoneNumber: String

    init?(record: CKRecord) {
        id = record.recordID
        guard let name = record[NLocation.kName] as? String,
              let description = record[NLocation.kDescription] as? String,
              let address = record[NLocation.kAddress] as? String,
              let websiteURL = record[NLocation.kWebsiteURL] as? String,
              let phoneNumber = record[NLocation.kPhoneNumber] as? String,
              let location = record[NLocation.kLocation] as? CLLocation else {
                  return nil
              }
        self.squareAsset = record[NLocation.kSquareAsset] as? CKAsset
        self.bannerAsset = record[NLocation.kBannerAsset] as? CKAsset
        self.name = name
        self.description = description
        self.address = address
        self.websiteURL = websiteURL
        self.phoneNumber = phoneNumber
        self.location = location
    }

    func createSquareImage() -> UIImage {
        guard let asset = squareAsset else { return PlaceholderImages.square }
        return asset.toUIImage(in: .square)
    }

    func createBannerImage() -> UIImage {
        guard let asset = bannerAsset else { return PlaceholderImages.banner }
        return asset.toUIImage(in: .banner)
    }
}
