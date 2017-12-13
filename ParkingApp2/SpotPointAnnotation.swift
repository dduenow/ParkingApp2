//
//  SpotPointAnnotation.swift
//  ParkingApp2
//
//  Created by Aidan Verhulst on 12/6/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import MapKit

class SpotPointAnnotation: MKPointAnnotation {
    var spot: Spot?

}

class ListingPointAnnotation: MKPointAnnotation{
    var listing: ParkingStruct?
}
