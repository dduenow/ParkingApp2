//
//  ListingViewController.swift
//  ParkingApp2
//
//  Created by Sean Winegar on 12/7/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var listingDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func RetrieveListings(_: [String]){
        //call retreive listings from listings page and load the info
    }

}
