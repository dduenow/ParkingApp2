//
//  ParkingSpot+CoreDataClass.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/9/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData

@objc(ParkingSpot)
public class ParkingSpot: NSManagedObject {
    var date: Date? {
    get {
    return dateAvailability as Date?
    }
    set(newDate){
    dateAvailability = newDate as NSDate?
    }
    }
    
    convenience init? (ownerUserId: String?, dateAvailability: Date?, parkingInformation: String?, price: Double, rented: Bool, renterUserId: String?, spotsAvailable: Int16, timeAvailable: String?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: ParkingSpot.entity(), insertInto: context)
        
        self.ownerUserId = ownerUserId
        self.date = dateAvailability
        self.parkingInformation = parkingInformation
        self.price = price
        self.rented = rented
        self.renterUserId = renterUserId
        self.spotsAvailable = spotsAvailable
        self.timeAvailability = timeAvailable
        
    }

}
