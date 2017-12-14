//
//  TableViewController.swift
//  ParkingApp2
//
//  Created by Sean Winegar on 12/5/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit

class TableViewController: UITableViewController {
    
    @IBOutlet var listingsTableView: UITableView!
    //dwdb79@mail.missouri.edu
    //testing table view
    //var names = ["Hitt Street", "Turner Avenue", "Rollins", "Parking garage #7"]
    var records = [CKRecord]()
    
    let privateDatabase = CKContainer.default().publicCloudDatabase
    let zone = CKRecordZone(zoneName: "_defaultZone")
    //This is not working correctly
    //<<False>>. It appears to not work if your private cloudkit db is empty
    func loadData() {
        let query = CKQuery(recordType: "ParkingStruct", predicate: NSPredicate(value: true))
        privateDatabase.perform(query, inZoneWith: zone.zoneID) { (ParkingStruct, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                else{
                    self.records = ParkingStruct ?? []
                    self.records = self.records.reversed()
                    self.listingsTableView.reloadData()
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
        listingsTableView.delegate = self
        listingsTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.records.count
    }
    
    //toDo: replace cell info with listing info
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let name = names[indexPath.row]
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        cell.textLabel?.text = name
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let record = records[indexPath.row]
        cell.textLabel?.text = record.object(forKey: "locationDescription") as? String
        
        return cell
    }
    //Allows us to send data to detail view by using segue as identifiable action
    //    func prepare(for segue: UIStoryboardSegue, sender: UITableViewCell?) {
    //        if let destination = segue.destination as? ListingViewController {
    //            let cell = sender
    //            let selectedRow = tableView.indexPath(for: cell!)!.row
    //            destination.selectedValue = records[selectedRow]
    //        }
    //
    //    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListingViewController {
            let cell = sender
            let selectedRow = tableView.indexPath(for: cell! as! UITableViewCell)!.row
            destination.selectedValue = records[selectedRow]
        }
    }
    
}

