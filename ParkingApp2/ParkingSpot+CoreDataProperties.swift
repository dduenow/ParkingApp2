//
//  ParkingSpot+CoreDataProperties.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/16/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//
//
import Foundation
import CoreData


extension ParkingSpot {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ParkingSpot> {
        return NSFetchRequest<ParkingSpot>(entityName: "ParkingSpot")
    }
    
    @NSManaged public var dateAvailability: NSDate?
    @NSManaged public var ownerUserId: String?
    @NSManaged public var parkingInformation: String?
    @NSManaged public var price: Double
    @NSManaged public var rented: Bool
    @NSManaged public var renterUserId: String?
    @NSManaged public var spotsAvailable: Int16
    @NSManaged public var timeAvailability: String?
    @NSManaged public var user: User?

}
