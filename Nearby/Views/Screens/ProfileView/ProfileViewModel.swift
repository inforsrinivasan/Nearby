//
//  ProfileViewModel.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-26.
//

import Foundation
import CloudKit

enum ProfileContext {
    case create
    case update
}

final class ProfileViewModel: ObservableObject {

    @Published var firstName = ""
    @Published var lastName = ""
    @Published var company = ""
    @Published var bio = ""
    @Published var avatar = PlaceholderImages.avatar
    @Published var isShowingPhotoPicker: Bool = false
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false

    var profileContext: ProfileContext = .create
    private var existingProfileRecord: CKRecord? {
        didSet { profileContext = .update }
    }

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
            alertItem = AlertContext.noUserRecord
            return
        }
        userRecord["userProfile"] = CKRecord.Reference(recordID: profileRecord.recordID, action: .none)
        showLoadingView()
        CloudKitManager.shared.batchSave(records: [userRecord, profileRecord]) { result  in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success:
                    alertItem = AlertContext.createProfileSuccess
                    existingProfileRecord = profileRecord
                    break
                case .failure(let error):
                    alertItem = AlertContext.createProfileFailure
                    print(error.localizedDescription)
                }
            }
        }
    }

    func getProfile() {
        guard let userRecord = CloudKitManager.shared.userRecord,
              let profileReference = userRecord["userProfile"] as? CKRecord.Reference else {
                  return
              }
        let profileRecordID = profileReference.recordID
        showLoadingView()
        CloudKitManager.shared.fetchRecord(with: profileRecordID) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let record):
                    guard let profile = NProfile(record: record) else { return }
                    firstName = profile.firstName
                    lastName = profile.lastName
                    company = profile.companyName
                    bio = profile.bio
                    avatar = profile.createAvatarImage()

                    existingProfileRecord = record
                case .failure(_):
                    alertItem = AlertContext.unableToRetrieveProfile
                    break
                }
            }
        }
    }

    func updateProfile() {
        guard isValidProfile() else {
            alertItem = AlertContext.invalidProfile
            return
        }

        guard let profileRecord = existingProfileRecord else {
            alertItem = AlertContext.unableToRetrieveProfile
            return
        }

        profileRecord[NProfile.kFirstName] = firstName
        profileRecord[NProfile.kLastName] = lastName
        profileRecord[NProfile.kBio] = bio
        profileRecord[NProfile.kCompanyName] = company
        profileRecord[NProfile.kAvatar] = avatar.convertToCKAsset()

        showLoadingView()
        CloudKitManager.shared.save(record: profileRecord) { result in
            DispatchQueue.main.async { [self] in
                hideLoadingView()
                switch result {
                case .success(let record):
                    existingProfileRecord = record
                    alertItem = AlertContext.updateProfileSuccess
                case .failure(let error):
                    print(error.localizedDescription)
                    alertItem = AlertContext.updateProfileFailed
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

    private func showLoadingView() {
        isLoading = true
    }

    private func hideLoadingView() {
        isLoading = false
    }

}
