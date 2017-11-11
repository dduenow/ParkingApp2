//
//  User+CoreDataProperties.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/9/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var userId: String?
    @NSManaged public var username: String?

}
