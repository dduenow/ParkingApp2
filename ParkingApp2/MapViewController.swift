//
//  MapViewController.swift
//  ParkingApp2
//
//  Created by Aidan Verhulst on 11/30/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initialLocation = CLLocation(latitude: 38.942491, longitude: -92.326973)
        
        //calls function below
        centerMapOnLocation(location: initialLocation)
        
        //sets ViewController as the delegate of mapView
        mapView.delegate = self
    }

    //sets north/south and east/west span to 1000 meters
    let regionRadius: CLLocationDistance = 1000
    //location is center point. setRegion tells mapView to display the region. animated adds a zoom effect
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
    




    extension MapViewController: MKMapViewDelegate {
        // 1 - gets called at every annotation added to the map
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            // 2 - check to make sure that thea annotation is an Artwork annotation - returns nil if not
//            guard let annotation = annotation as? Artwork else { return nil }
            // 3 - makes each view an MKMarkerAnnotationView in order to make markers pop up
            let identifier = "marker"
            var view: MKMarkerAnnotationView
            // 4 - check to see if reusable annotation view is available before adding a new one
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKMarkerAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 5 - Creates a new MKMarkerAnnotationView object
                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            return view
            
        }
        //tells MapKit what to do when the user hits the callout button
//        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//                     calloutAccessoryControlTapped control: UIControl) {
////            let location = view.annotation as! Artwork
//            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//            location.mapItem().openInMaps(launchOptions: launchOptions)
//        }
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

