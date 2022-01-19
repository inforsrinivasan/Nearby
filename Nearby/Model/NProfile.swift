//
//  NProfile.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-19.
//

import CloudKit

struct NProfile {

    static let kFirstName = "firstName"
    static let kLastName = "lastName"
    static let kAvatar = "avatar"
    static let kCompanyName = "companyName"
    static let kBio = "bio"
    static let kIsCheckedIn = "isCheckedIn"


    let ckRecordID: CKRecord.ID
    let firstName: String
    let lastName: String
    let avatar: CKAsset
    let companyName: String
    let bio: String
    let isCheckedIn: CKRecord.Reference? = nil

    init?(record: CKRecord) {
        ckRecordID = record.recordID
        guard let firstName = record[NProfile.kFirstName] as? String,
              let lastName = record[NProfile.kLastName] as? String,
              let avatar = record[NProfile.kAvatar] as? CKAsset,
              let companyName = record[NProfile.kCompanyName] as? String,
              let bio = record[NProfile.kBio] as? String else {
                  return nil
              }
        self.firstName = firstName
        self.lastName = lastName
        self.avatar = avatar
        self.companyName = companyName
        self.bio = bio
    }
}

