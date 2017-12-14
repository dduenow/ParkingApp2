//
//  RenterViewController.swift
//  ParkingApp2
//
//  Created by Abudy on 12/12/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit

class RenterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var renterViewtable: UITableView!
    
    
    var records = [CKRecord]()
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let zone = CKRecordZone(zoneName: "_defaultZone")
    //This is not working correctly
    //<<False>>. It appears to not work if your private cloudkit db is empty
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
                    self.renterViewtable.reloadData()
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
        renterViewtable.delegate = self
        renterViewtable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
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
        return self.records.count
    }
    
    //toDo: replace cell info with listing info
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let record = records[indexPath.row]
        cell.textLabel?.text = record.object(forKey: "locationDescription") as? String
        
        return cell
}
}
