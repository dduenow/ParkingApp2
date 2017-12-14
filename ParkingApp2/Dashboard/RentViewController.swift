//
//  RentViewController.swift
//  ParkingApp2
//
//  Created by Benson Philipose on 12/13/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit


class RentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var rentTableView: UITableView!
    var parkStruct: [ParkingStruct] = []
    
    
    var records = [CKRecord]()
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let zone = CKRecordZone(zoneName: "_defaultZone")
    //This is not working correctly
    //<<False>>. It appears to not work if your private cloudkit db is empty
    //Now loading in public database
    func loadData() {
        let query = CKQuery(recordType: "ParkingStruct", predicate: NSPredicate(value: true))
        publicDatabase.perform(query, inZoneWith: zone.zoneID) { (ParkingStruct, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                else{
                    self.records = ParkingStruct ?? []
                    self.records = self.records.reversed()
                    self.rentTableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        self.title = nil;
        //loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        rentTableView.delegate = self
        rentTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        loadData()
        let cloud = Cloud.defaultPublicDatabase()
        
        cloud.retrieveObjects { (values: [ParkingStruct], error) in
            if let error = error {
                print(error)
            } else {
                self.parkStruct = values
                self.rentTableView.reloadData()
            }
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.parkStruct.count
    }
    
    //toDo: replace cell info with listing info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let record = parkStruct[indexPath.row]
        cell.textLabel?.text = record.locationDescription
        
        return cell
    }
    //Allows us to send data to detail view by using segue as identifiable action
    //    func prepare(for segue: UIStoryboardSegue, sender: UITableViewCell?) {
    //        if let destination = segue.destination as? ListingViewController {
    //            let cell = sender
    //            let selectedRow = sellerTableview.indexPath(for: cell!)!.row
    //            destination.selectedValue = records[selectedRow]
    //        }
    
}


