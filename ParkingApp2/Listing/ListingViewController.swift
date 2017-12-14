//
//  ListingViewController.swift
//  ParkingApp2
//
//  Created by Sean Winegar on 12/7/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit

class ListingViewController: UIViewController {
    
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var listingDescription: UITextView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    var selectedValue: CKRecord = CKRecord(recordType: "ParkingStruct")
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.title? = selectedValue.value(forKey: "locationDescription") as! String
        displayAvailability()
        size.text? = selectedValue.value(forKey: "carSize") as! String
        price.text? = selectedValue.value(forKey: "price") as! String
        listingDescription.text? = selectedValue.value(forKey: "description") as! String
        //set attribute values to display
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAvailability() {
        let startDate = selectedValue.value(forKey: "startDate") as! NSDate
        let endDate = selectedValue.value(forKey: "endDate") as! NSDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd hh:mm"
        let startDateString = dateFormatter.string(from:startDate as Date)
        let endDateString = dateFormatter.string(from:endDate as Date)
        
        let finalDateString = startDateString + " - " + endDateString
        availability.text = finalDateString
        
    }

}
