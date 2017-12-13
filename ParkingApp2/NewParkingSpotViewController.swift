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

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationDescriptionField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var contactMethodTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    var startDate: Date?
    var endDate: Date?
    
    let sizePickerData = ["Car", "Truck", "SUV", "Jeep"]
    
    let dateFormatter: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    let sizePickerView = UIPickerView()
    let datePicker = UIDatePicker()
    let toolBar: UIToolbar = {
        let bar = UIToolbar()
        bar.barStyle = .default
        bar.isTranslucent = true
        bar.sizeToFit()
        
        bar.isUserInteractionEnabled = true
        
        return bar
    }()
    
    var firstName: String?
    var lastName: String?
    var email: String = "dwdb79@mail.missouri.edu"
    
    let publicDatabase = CKContainer.default().publicCloudDatabase
    let recordZone = CKRecordZone(zoneName: "ParkingZone")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizePickerView.dataSource = self
        sizePickerView.delegate = self
        locationDescriptionField.delegate = self
        sizeTextField.delegate = self
        priceTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(NewParkingSpotViewController.resignKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        startDateTextField.inputView = datePicker
        startDateTextField.inputAccessoryView = toolBar
        startDateTextField.tintColor = .clear
        
        endDateTextField.inputView = datePicker
        endDateTextField.inputAccessoryView = toolBar
        endDateTextField.tintColor = .clear
        
        sizeTextField.inputView = sizePickerView
        sizeTextField.inputAccessoryView = toolBar
        sizeTextField.tintColor = .clear
        
//        CKContainer.default().requestApplicationPermission(.userDiscoverability) { (status, error) in
//            CKContainer.default().fetchUserRecordID { (record, error) in
//                CKContainer.default().discoverUserIdentity(withUserRecordID: record!, completionHandler: { (userID, error) in
//                    print(userID?.hasiCloudAccount)
//                    print(userID?.lookupInfo?.phoneNumber)
//                    print(userID?.lookupInfo?.emailAddress)
//                    print((userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!)
//                })
//            }
//        }
        
        Cloud.defaultPublicDatabase().userInformation { (user, error) in
            self.firstName = user?.firstName
            self.firstName? += " "
            self.firstName? += (user?.lastName)!
            self.lastName = user?.lastName
                }
    }
    
    @objc func resignKeyboard() {
        descriptionTextField.resignFirstResponder()
        locationDescriptionField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        sizePickerView.resignFirstResponder()
        priceTextField.resignFirstResponder()
        contactMethodTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        datePicker.resignFirstResponder()
        nameTextField.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignKeyboard()
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
    
    @IBAction func changeDateStart(_ sender: UITextField) {
        startDateTextField.text = dateFormatter.string(from: datePicker.date)
        startDate = datePicker.date
    }
    
    @IBAction func changeDateEnd(_ sender: UITextField) {
        endDateTextField.text = dateFormatter.string(from: datePicker.date)
        endDate = datePicker.date
    }
    
    
    @IBAction func saveSpot(_ sender: Any){

        let listing = ParkingStruct(cloudInformation: nil, name: firstName!, rentorEmail: email, startDate: startDate!, endDate: endDate!, locationDescription: locationDescriptionField.text!, price: priceTextField.text!, carSize: sizeTextField.text!, description: descriptionTextField.text!, contactMethod: contactMethodTextField.text!, renteeEmail: nil)
        
        guard let firstName = firstName, !firstName.isEmpty else {
            // raise error
            return
        }
        
        let cloud = Cloud.defaultPublicDatabase()
        
        cloud.save(listing) { (error) in
            if let error = error {
                let alertController = UIAlertController(title: "Opps", message: "It seems we were unable to save your listing. Please check your internet connection.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                print(error)
            } else {
                print("Listing saved")
//                self.navigationController?.popViewController(animated: true)
            }
        }
//        let date = datePicker.date as CKRecordValue
        
//        record.setObject(date, forKey: "date")
        
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
        descriptionTextField.resignFirstResponder()
        locationDescriptionField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        sizePickerView.resignFirstResponder()
        priceTextField.resignFirstResponder()
        contactMethodTextField.resignFirstResponder()
        startDateTextField.resignFirstResponder()
        endDateTextField.resignFirstResponder()
        datePicker.resignFirstResponder()
        nameTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        sizeTextField.text = sizePickerData.first
        return true
    }
}



//struct User {
//    var id: String
//}
//
//NSPredicate(format: "id == %@", "moorest@missouri.edu")

