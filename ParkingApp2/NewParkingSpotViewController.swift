//
//  NewParkingSpotViewController.swift
//  ParkingApp2
//
//  Created by David Duenow on 11/16/17.
//  Copyright © 2017 David Duenow. All rights reserved.
//

import UIKit
import CloudKit

class NewParkingSpotViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var locationDescriptionField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var contactMethodTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var savingView: UIView!
    @IBOutlet weak var savingActivityIndicator: UIActivityIndicatorView!
    
    var startDate: Date?
    var endDate: Date?
    
    var firstName: String?
    var lastName: String?
    
    let sizePickerData = ["Car", "Truck", "SUV", "Jeep"]
    
    let dateFormatter: DateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    let sizePickerView = UIPickerView()
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    let toolBar: UIToolbar = {
        let bar = UIToolbar()
        bar.barStyle = .default
        bar.isTranslucent = true
        bar.sizeToFit()
        
        bar.isUserInteractionEnabled = true
        
        return bar
    }()
    
    var email: String = "dwdb79@mail.missouri.edu"
        
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
        
        startDateTextField.inputView = startDatePicker
        startDateTextField.inputAccessoryView = toolBar
        startDateTextField.tintColor = .clear

        endDateTextField.inputView = endDatePicker
        endDateTextField.inputAccessoryView = toolBar
        endDateTextField.tintColor = .clear
        
        sizeTextField.inputView = sizePickerView
        sizeTextField.inputAccessoryView = toolBar
        sizeTextField.tintColor = .clear
        
        sizeTextField.text = sizePickerData[0]
        

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
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeDateStart(_ sender: UITextField) {
        startDateTextField.text = dateFormatter.string(from: startDatePicker.date)
        startDate = startDatePicker.date
    }
    
    @IBAction func changeDateEnd(_ sender: UITextField) {
        endDateTextField.text = dateFormatter.string(from: endDatePicker.date)
        endDate = endDatePicker.date.addingTimeInterval(30.0 * 60.0)
    }
    
    
    @IBAction func saveSpot(_ sender: UIBarButtonItem){
        savingView.isHidden = false
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
       
        guard let locationDescription = locationDescriptionField.text, !(locationDescriptionField.text?.isEmpty ?? true) else {
            let alertController = UIAlertController(title: "Missing Info", message: "Location description has not been filled out. Please fill out this field.", preferredStyle: .alert)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            savingView.isHidden = true
            return
        }
        
        guard let price = priceTextField.text, !(priceTextField.text?.isEmpty ?? true) else {
            let alertController = UIAlertController(title: "Missing Info", message: "Price has not been set. Please set a price.", preferredStyle: .alert)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            savingView.isHidden = true
            return
        }
        
        guard let description = descriptionTextField.text, !(descriptionTextField.text?.isEmpty ?? true) else {
            let alertController = UIAlertController(title: "Missing Info", message: "Description has not been filled out. Please fill out this field.", preferredStyle: .alert)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            savingView.isHidden = true
            return
        }
        
        guard let startDate = startDate, !(startDateTextField.text?.isEmpty ?? true) else {
            let alertController = UIAlertController(title: "Missing Info", message: "Start date is missing. Please select a start time.", preferredStyle: .alert)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            savingView.isHidden = true
            return
        }
        
        guard let endDate = endDate, !(endDateTextField.text?.isEmpty ?? true) else {
            let alertController = UIAlertController(title: "Missing Info", message: "End date is missing. Please select an end time.", preferredStyle: .alert)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
            savingView.isHidden = true
            return
        }
        
        guard let carSize = sizeTextField.text, !(sizeTextField.text?.isEmpty ?? true) else {
                let alertController = UIAlertController(title: "Missing Info", message: "Car size is not filled out. Please fill out this field.", preferredStyle: .alert)
            
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                savingView.isHidden = true
            return
        }
        
        guard let contactMethod = contactMethodTextField.text, !(descriptionTextField.text?.isEmpty ?? true) else {
                let alertController = UIAlertController(title: "Missing Info", message: "End time for the spot has not been set.", preferredStyle: .alert)
            
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                savingView.isHidden = true
            return
        }
        
        let cloud = Cloud.defaultPublicDatabase()
        cloud.userInformation { (user , error) in
            if let _ = error {
                let alertController = UIAlertController(title: "Opps", message: "It seems we were unable to save your listing. Please check your internet connection.", preferredStyle: .alert)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.firstName = user?.firstName
                self.lastName = user?.lastName
            }
        }
        
        guard let firstName = firstName else{
                savingView.isHidden = true
            return
        }
        
        guard let lastName = lastName else {
                savingView.isHidden = true
            return
        }
        
        let name = firstName + " " + lastName
        
        let listing = ParkingStruct(cloudInformation: nil, rentorName: name, rentorEmail: email, startDate: startDate, endDate: endDate, locationDescription: locationDescription, price: price, carSize: carSize, description: description, contactMethod: contactMethod, renteeEmail: nil, renteeName: nil)
        
        cloud.save(listing) { (error) in
            if let _ = error {
                let alertController = UIAlertController(title: "Opps", message: "It seems we were unable to save your listing. Please check your internet connection.", preferredStyle: .alert)

                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
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
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        sizeTextField.text = sizePickerData.first
        
        if textField === startDateTextField {
            startDatePicker.minimumDate = Date()
            endDatePicker.minimumDate = Date(timeInterval: 30.0 * 60.0, since: startDatePicker.date)
            endDate = endDatePicker.date
            endDateTextField.text = dateFormatter.string(from: endDatePicker.date)
        }
        endDateTextField.isEnabled = true
        return true
    }
}

extension NewParkingSpotViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
}
