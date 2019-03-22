//
//  RequestStopVC.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/29/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit

class RequestStopVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

	@IBOutlet weak var busNumText: UITextField!
	@IBOutlet weak var stopTextField: UITextField!
	
	var busDetails = BusDetails()
	
	var busNumberArray = ["1101",
						  "1104",
						  "1106",
						  "1107",
						  "1108",
						  "1109",
						  "1110",
						  "1111",
						  "1112",
						  "1113",
						  "1114",
						  "1115",
						  "1117",
						  "1118",
						  "1122",
						  "1171",
						  "1172",
						  "1173",
						  "1310"]
	
	//var busStopsArray = [Stops]()
	
	var busStopsArray = ["Chestnut Hill Ave", "Main Gate", "Conte"]
	
	var routeNameArray = ["Comm Ave All Stops",
						  "Comm Ave Direct",
						  "Comm Ave Direct Express",
						  "Newton Eagle All Stops",
						  "Newton Eagle Direct",
						  "Newton Eagle Limited",
						  "Brighton Shuttle",
						  "Bus Not in Use"]
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
	
		//selectStopPV.delegate = self
		//selectStopPV.dataSource = self
		
		let picker: UIPickerView
		picker = UIPickerView(frame: .init())
		//picker.backgroundColor = .white
		picker.showsSelectionIndicator = true
		picker.delegate = self
		picker.dataSource = self
		
		let toolBar = UIToolbar()
		toolBar.barStyle = UIBarStyle.default
		toolBar.isTranslucent = true
		toolBar.tintColor = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1)
		toolBar.sizeToFit()
		
		let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: "donePicker")
		let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
		let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: "donePicker")
		
		toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
		toolBar.isUserInteractionEnabled = true
		
		stopTextField.inputView = picker
		stopTextField.inputAccessoryView = toolBar


    }
	
	// MARK:- UIPickerView
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return busStopsArray.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return busStopsArray[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		stopTextField.text = String(busStopsArray[row])
		pickerView.resignFirstResponder()
	}
	
	@objc func donePicker() {
		stopTextField.resignFirstResponder()
	}
	
		
//	func showAlert(title: String, message: String) {
//		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//		let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//		alertController.addAction(defaultAction)
//		present(alertController, animated: true, completion: nil)
//
//	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as! AllRequestedStopsViewController
		destination.busDetails = busDetails
		
	}
	

	

	@IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
		print(busNumText!)
		print("❤️")
		print(stopTextField!)
		
		busDetails.savedStops.append(StopInfo(stopName: stopTextField.text!, busNumber: busNumText.text!))
		// stopTextField.text! busNumText.text!
		busNumText.text = ""
		stopTextField.text = ""
		
		performSegue(withIdentifier: "ShowStops", sender: nil)
		
	}
	
}


