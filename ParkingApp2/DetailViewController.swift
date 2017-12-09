//
//  DetailViewController.swift
//  ParkingApp2
//
//  Created by Aidan Verhulst on 12/9/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var spot: Spot?
    
    @IBOutlet weak var datesAvail: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var rentButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let spot = spot {
            priceLabel.text = spot.price.description
            sizeLabel.text = spot.size
            detailLabel.text = spot.detail
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
