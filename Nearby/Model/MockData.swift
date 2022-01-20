//
//  MockData.swift
//  Nearby
//
//  Created by Srinivasan Rajendran on 2022-01-19.
//

import CloudKit

struct MockData {
    static var location: CKRecord {
        let record = CKRecord(recordType: RecordType.location)
        record[NLocation.kName]         = "Srini's Chilli Chicken Resturant"
        record[NLocation.kAddress]      = "123 Main Street"
        record[NLocation.kDescription]  = "This is a test description for testing purposes only"
        record[NLocation.kWebsiteURL]   = "https://www.google.com"
        record[NLocation.kLocation]     = CLLocation(latitude: 59.3293, longitude: 18.0686)
        record[NLocation.kPhoneNumber]  = "+46727859492"
        return record
    }
}
