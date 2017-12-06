//
//  NewParkingSpotViewController.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/16/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit

class NewParkingSpotViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sizePickerView: UIPickerView!
    @IBOutlet weak var sizeTextField: UITextField!
    
    var user: User?
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let recordZone = CKRecordZone(zoneName: "ParkingZone")
    let sizePickerData = ["Car", "Truck", "SUV", "Jeep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        textField.delegate = self
        sizeTextField.delegate = self
        sizePickerView.isHidden = true
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        sizePickerView.resignFirstResponder()
        sizePickerView.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sizePickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sizePickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        sizeTextField.text = sizePickerData[row]
    }
    
    @IBAction func sizeTextFieldFocused(_ sender: UITextField) {
        sizePickerView.isHidden = false
    }
    
    @IBAction func sizeTextFieldUnfocused(_ sender: UITextField) {
        sizePickerView.isHidden = true
    }
    
    @IBAction func saveSpot(_ sender: Any){
        let record = CKRecord(recordType: "Parking", zoneID: recordZone.zoneID)
        
        let date = datePicker.date as CKRecordValue
        
        record.setObject(date, forKey: "date")
        
//        CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in
//            CKContainer.default().fetchUserRecordID(completionHandler: { (record, error) in
//                if let record = record {
//                    CKContainer.default().discoverUserIdentity(withUserRecordID: record, completionHandler: { (userID, error) in
//                        if let userID = userID {
//                            print(userID.nameComponents?.givenName)
//                            print(userID.lookupInfo?.emailAddress)
//                        }
//                    })
//                }
//            })
//        }
        
    }
}

extension NewParkingSpotViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == sizeTextField){
            sizePickerView.isHidden = false
            return false
        }
        return true
    }
}
