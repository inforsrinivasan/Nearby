//
//  ProfileViewModel.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-26.
//

import Foundation
import CloudKit

final class ProfileViewModel: ObservableObject {

    @Published var firstName = ""
    @Published var lastName = ""
    @Published var company = ""
    @Published var bio = ""
    @Published var avatar = PlaceholderImages.avatar
    @Published var isShowingPhotoPicker: Bool = false
    @Published var alertItem: AlertItem?

    func isValidProfile() -> Bool {

        guard !firstName.isEmpty,
              !lastName.isEmpty,
              !bio.isEmpty,
              !bio.isEmpty,
              avatar != PlaceholderImages.avatar,
              bio.count <= 100 else { return false }

        return true
    }

    func createProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }

        let profileRecord = createProfileRecord()

        guard let userRecord = CloudKitManager.shared.userRecord else {
            return
        }
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result  in
            switch result {
            case .success:
                // show alert
                break
            case .failure(let error):
                // show alert
                print(error.localizedDescription)
            }
        }
    }

    func getProfile() {
        guard let userRecord = CloudKitManager.shared.userRecord,
              let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
                  // show alert
                  return
              }
        let profileRecordID = profileReference.recordID
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let record):
                    guard let profile = NProfile(record: record) else { return }
                    firstName = profile.firstName
                    lastName = profile.lastName
                    company = profile.companyName
                    bio = profile.bio
                    avatar = profile.createAvatarImage()
                case .failure(_):
                    // show alert
                    break
                }
            }
        }
    }

    private func createProfileRecord() -> CKRecord {
        let profileRecord = CKRecord(recordType: RecordType.profile)
        profileRecord[NProfile.kFirstName] = firstName
        profileRecord[NProfile.kLastName] = lastName
        profileRecord[NProfile.kBio] = bio
        profileRecord[NProfile.kCompanyName] = company
        profileRecord[NProfile.kAvatar] = avatar.convertToCKAsset()
        return profileRecord
    }

}
