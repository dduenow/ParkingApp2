//
//  User+CoreDataProperties.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/16/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var userId: String?
    @NSManaged public var username: String?
    @NSManaged public var rawParking: NSOrderedSet?

}

// MARK: Generated accessors for rawParking
extension User {

    @objc(insertObject:inRawParkingAtIndex:)
    @NSManaged public func insertIntoRawParking(_ value: ParkingSpot, at idx: Int)

    @objc(removeObjectFromRawParkingAtIndex:)
    @NSManaged public func removeFromRawParking(at idx: Int)

    @objc(insertRawParking:atIndexes:)
    @NSManaged public func insertIntoRawParking(_ values: [ParkingSpot], at indexes: NSIndexSet)

    @objc(removeRawParkingAtIndexes:)
    @NSManaged public func removeFromRawParking(at indexes: NSIndexSet)

    @objc(replaceObjectInRawParkingAtIndex:withObject:)
    @NSManaged public func replaceRawParking(at idx: Int, with value: ParkingSpot)

    @objc(replaceRawParkingAtIndexes:withRawParking:)
    @NSManaged public func replaceRawParking(at indexes: NSIndexSet, with values: [ParkingSpot])

    @objc(addRawParkingObject:)
    @NSManaged public func addToRawParking(_ value: ParkingSpot)

    @objc(removeRawParkingObject:)
    @NSManaged public func removeFromRawParking(_ value: ParkingSpot)

    @objc(addRawParking:)
    @NSManaged public func addToRawParking(_ values: NSOrderedSet)

    @objc(removeRawParking:)
    @NSManaged public func removeFromRawParking(_ values: NSOrderedSet)

}
