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
    
    var selectedValue: CKRecord = CKRecord(recordType: "ParkingSpot")
    override func viewDidLoad() {
        super.viewDidLoad()
        //set attribute values to display
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
