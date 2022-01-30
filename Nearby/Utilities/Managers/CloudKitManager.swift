//
//  CloudKitManager.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import CloudKit

class CloudKitManager {

    static let shared = CloudKitManager()

    var userRecord: CKRecord?

    private init() { }

    func getUserRecord() {
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
                self.userRecord = userRecord
            }
        }
    }

    func getLocations(completion: @escaping (Result<[NLocation], Error>) -> Void) {
        let query = CKQuery(recordType: RecordType.location, predicate: NSPredicate(value: true))
        let sortNameDescriptor = NSSortDescriptor(key: NLocation.kName, ascending: true)
        query.sortDescriptors = [sortNameDescriptor]

        CKContainer.default().publicCloudDatabase.perform(query,
                                                          inZoneWith: nil) { records, error in
            guard error == nil else { return completion(.failure(error!)) }
            guard let records = records else { return completion(.success([])) }
            let locations: [NLocation] = records.compactMap(NLocation.init)
            completion(.success(locations))
        }
    }

    func batchSave(records: [CKRecord], completed: @escaping (Result<Void, Error>) -> Void) {
        let saveOperation = CKModifyRecordsOperation(recordsToSave: records)
        saveOperation.modifyRecordsResultBlock = completed
        CKContainer.default().publicCloudDatabase.add(saveOperation)
    }

    func save(record: CKRecord, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.save(record) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
        }
    }

    func fetchRecord(with id: CKRecord.ID, completed: @escaping (Result<CKRecord, Error>) -> Void) {
        CKContainer.default().publicCloudDatabase.fetch(withRecordID: id) { record, error in
            guard let record = record, error == nil else {
                completed(.failure(error!))
                return
            }
            completed(.success(record))
        }
    }

}
