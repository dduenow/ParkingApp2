//
//  User+CoreDataClass.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/9/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//
//

import UIKit
import CoreData

@objc(User)
public class User: NSManagedObject {
    var parkingSpots: [ParkingSpot]? {
        return rawParking?.array as? [ParkingSpot]
    }
    
    convenience init?(userId: String?, username: String?){
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: User.entity(), insertInto: context)
        
        self.userId = userId
        self.username = username
    }
}
