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

        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID,
                  error == nil else {
                      print(error!.localizedDescription)
                      return
                  }

            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { record, error in
                guard let userRecord = record,
                      error == nil else {
                          print(error!.localizedDescription)
                          return
                      }
                userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)

                let saveOperation = CKModifyRecordsOperation(recordsToSave: [userRecord, profileRecord])
                saveOperation.modifyRecordsResultBlock = { result in
                    switch result {
                    case .success:
                        print("Success")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                CKContainer.default().publicCloudDatabase.add(saveOperation)
            }
        }
    }

    func getProfile() {
        CKContainer.default().fetchUserRecordID { recordID, error in
            guard let recordID = recordID,
                  error == nil else {
                      print(error!.localizedDescription)
                      return
                  }
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordID) { userRecord, error in
                guard let userRecord = userRecord,
                      error == nil else {
                          print(error!.localizedDescription)
                          return
                      }

                let profileReference = userRecord["userProfile"] as! CKRecord.Reference
                let profileRecordID = profileReference.recordID

                CKContainer.default().publicCloudDatabase.fetch(withRecordID: profileRecordID) { profileRecord, error in
                    guard let profileRecord = profileRecord,
                          error == nil else {
                              print(error!.localizedDescription)
                              return
                          }
                    DispatchQueue.main.async { [self] in
                        guard let profile = NProfile(record: profileRecord) else { return }

                        firstName   = profile.firstName
                        lastName    = profile.lastName
                        company     = profile.companyName
                        bio         = profile.bio
                        avatar      = profile.createAvatarImage()
                    }
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
