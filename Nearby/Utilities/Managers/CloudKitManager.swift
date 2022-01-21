//
//  CloudKitManager.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-20.
//

import CloudKit

struct CloudKitManager {

    static func getLocations(completion: @escaping (Result<[NLocation], Error>) -> Void) {
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

}
