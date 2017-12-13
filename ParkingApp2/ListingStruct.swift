//
//  ListingStruct.swift
//  ParkingApp2
//
//  Created by David Duenow on 12/7/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import Foundation
import CloudKit

struct ParkingStruct : CloudKitCodable {
    let recordType = "ParkingStruct"
    var cloudInformation: CloudKitInformation?
    var name: String
    var rentorEmail: String
    var startDate: Date
    var endDate: Date
    var locationDescription: String
    var price: String
    var carSize: String
    var description: String?
    var contactMethod: String
    var renteeEmail: String?
}

    
