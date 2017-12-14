//
//  MapViewController.swift
//  ParkingApp2
//
//  Created by Aidan Verhulst on 12/6/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import MapKit
import CloudKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let annotationIdentifier = "spot"
    var selectedAnnotation: SpotPointAnnotation?
    
    var records = [CKRecord]()
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let recordZone = CKRecordZone(zoneName: "ParkingZone")
    
    func loadData() {
        let query = CKQuery(recordType: "ParkingStruct", predicate: NSPredicate(value: true))
        publicDatabase.perform(query, inZoneWith: nil) { (ParkingStruct, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                else{
                    self.records = ParkingStruct ?? []
                    self.records = self.records.reversed()
//                    self.MapViewController.reloadData()
                }
            }
        }
    }
    
    var firstName: String?
    var lastName: String?
    var email: String = "aavr56@mail.missouri.edu"
    
    let centerLatitude = 40.00
    let centerLongitude = -90.00
    //these two decide how much of the map you can view.
    let latitudeDelta = 0.01
    let longitudeDelta = 0.01
    
    //using array of spots, which is a test class, to test out MKpoints
    var spots: [Spot] = [
        Spot(latitude: 38.946336, longitude: -92.330565,
                 title: "Test1", subtitle: "University of Missouri",
                 price: 1.00, size: "Two normal vehicles", detail: "normal spot that can fit two vehiclesasdfasdfasdfal;sdkfjasl;dkfjals;dkfjas;ldkfja;ldskfja;", spotImage: "park1"),
        Spot(latitude: 38.945176, longitude: -92.328838,
                 title: "T2", subtitle: "University of Missouri",
                 price: 1.00, size: "One spaceship", detail: "parking spot available for one spaceship", spotImage: "park2"),
        Spot(latitude: 38.947889, longitude: -92.329506,
                 title: "T3", subtitle: "University of Missouri",
                 price: 1.00, size: "1 vehicle", detail: "extra spot available at my house", spotImage: "park3"),
        Spot(latitude: 38.948689, longitude: -92.327841,
                 title: "T4", subtitle: "Columbia, MO",
                 price: 1.00, size: "up to a large truck", detail: "enough room for a large vehicle", spotImage: "park4"),
        Spot(latitude: 38.950132, longitude: -92.332251,
                 title: "T5", subtitle: "Columbia, Missouri",
                 price: 1.00, size: "one limo", detail: "got a spot for a limo here", spotImage: "park5")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        //
        mapView.delegate = self
        
        let centerLocation = spots[0]
        
        let center = CLLocationCoordinate2D(latitude: centerLocation.latitude, longitude: centerLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        
        for spot in spots {
            let point = SpotPointAnnotation()
            point.spot = spot
            point.coordinate = CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude)
            point.title = spot.title
            point.subtitle = spot.subtitle
            mapView.addAnnotation(point)
        }
        
        
        Cloud.defaultPublicDatabase().userInformation { (user, error) in
            self.firstName = user?.firstName
            self.firstName? += " "
            self.firstName? += (user?.lastName)!
            self.lastName = user?.lastName
        }
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            view?.canShowCallout = true
            view?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            view?.annotation = annotation
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            selectedAnnotation = view.annotation as? SpotPointAnnotation
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController, let annotation = selectedAnnotation, let spot = annotation.spot {
            destination.spot = spot
        }
    }

    

}
