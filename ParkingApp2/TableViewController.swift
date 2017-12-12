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
    
    let publicDatabase = CKContainer.default().privateCloudDatabase
    let zone = CKRecordZone(zoneName: "_defaultZone")
    //This is not working correctly
    func loadData() {
        let query = CKQuery(recordType: "ParkingStruct", predicate: NSPredicate(value: true))
        publicDatabase.perform(query, inZoneWith: zone.zoneID) { (ParkingStruct, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                else{
                    self.records = ParkingStruct ?? []
                    
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
    func prepare(for segue: UIStoryboardSegue, sender: UITableViewCell?) {
        if let destination = segue.destination as? ListingViewController {
            let cell = sender
            let selectedRow = tableView.indexPath(for: cell!)!.row
            destination.selectedValue = records[selectedRow]
        }
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
