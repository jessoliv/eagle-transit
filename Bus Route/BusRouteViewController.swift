//
//  BusRouteViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/26/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

class BusRouteViewController: UIViewController {
	
	@IBOutlet weak var commAveLabel: UIButton!
	@IBOutlet weak var newtonLabel: UIButton!
	@IBOutlet weak var brightonLabel: UIButton!
	@IBOutlet weak var lawSchoolLabel: UIButton!
	@IBOutlet weak var groceryLabel: UIButton!
	@IBOutlet weak var otherBusLabel: UIButton!
	
	var busDetails = BusDetails()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationController?.navigationBar.barTintColor=UIColor(displayP3Red: 134/255, green: 38/255, blue: 31/255, alpha: 1)
		//(red: 134/255, green: 38/255, blue: 31/255)

	}
	
	
	override func viewWillAppear(_ animated: Bool) {
		navigationItem.title = "Boston College Shuttle Bus"
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier ?? "" {
		case "ShowAllNewtonRt":
			let destination = segue.destination as! PossibleRoutesViewController
			destination.busDetails = busDetails
			destination.navigationTitleLabel = "Choose Newton Bus Route"
			destination.routeLabelOne = "Newton Eagle All Stops"
			destination.routeLabelTwo = "Newton Eagle Direct"
			destination.routeLabelThree = "Newton Eagle Limited"
			
			destination.routeOneLabel?.setTitle("Newton Eagle All Stops", for: .normal)
			destination.routeTwoLabel?.setTitle("Newton Eagle Direct", for: .normal)
			destination.routeThreeLabel?.setTitle("Newton Eagle Limited", for: .normal)
			
		case "ShowAllCommRt":
			let destination = segue.destination as! PossibleRoutesViewController
			destination.busDetails = busDetails
			destination.routeLabelOne = "Comm Ave All Stops"
			destination.routeLabelTwo = "Comm Ave Direct"
			destination.routeLabelThree = "Comm Ave Direct Express"
			
			destination.navigationTitleLabel = "Choose Comm Ave Bus"
			destination.routeOneLabel?.setTitle("Comm Ave All Stops", for: .normal)
			destination.routeTwoLabel?.setTitle("Comm Ave Direct", for: .selected)
			destination.routeThreeLabel?.setTitle("Comm Ave Direct Express", for: .selected)
			
		case "ShowBrightonBus":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			destination.navigationTitleLabel = "Brighton Shuttle"
		case "ShowLawBus":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			destination.navigationTitleLabel = "Law School Shuttle"
		case "ShowGroceryBus":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			destination.navigationTitleLabel = "Grocery Shuttle"
		case "ShowOtherBus":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			destination.navigationTitleLabel = "Other Bus Routes"
		case "ShowAbout":
			let destination = segue.destination as! AboutViewController
			destination.navigationTitleLabel = "About BC Shuttles"
		case "ShowHours":
			let destination = segue.destination as! HoursViewController
			destination.navigationTitleLabel = "Hours of Operation"
		default:
			print("*** ERROR: did not have a segue in SpotDetailViewController prepare(for: segue)")
		}
	}
	
	func showAlert(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
		alertController.addAction(defaultAction)
		present(alertController, animated: true, completion: nil)
	}


	@IBAction func commAveButtonPressed(_ sender: UIButton) {
	}
	
	@IBAction func newtonButtonPressed(_ sender: UIButton) {
	}
	
	@IBAction func brightonButtonPressed(_ sender: UIButton) {
		print("starting")
		//let allStops = getStopDictionary()
		//let allRoutes = getRouteDictionary()
		
		let tempRoute = "4005570" //route_id of Brighton Shuttle
		let tempStops = "4191290%2C4211344%2C4197490%2C4068926%2C4160246%2C4211340%2C4068910%2C4068914%2C4068902%2C" //all stops for Brighton Shuttle (MISSING 'Brighton Dance Studio')
		let allEstimatedArrivals = getEstimatedArrivalsDictionary(routes: tempRoute, stops: tempStops)
		print(allEstimatedArrivals)
		routeID = "4005570"
		print("done")
		
		// Tried this to grab data
		var array = (allEstimatedArrivals["data"]! as! NSArray).mutableCopy() as! NSMutableArray
		print(array)
		let json = JSON(NSValue.self)
		let numberOfStops = json["stop_id"].count
		print(numberOfStops)
		for index in 0..<numberOfStops {
			let stop_id = json["data"]["stop_id"].stringValue
			print("🙃🙃\(stop_id)")
			let arrival_at = json["data"][index]["arrivals"][index]["arrival_at"].stringValue
			let vehicle_id = json["data"][index]["arrivals"][index]["vehicle_id"].stringValue
		}

	
	}
	
	@IBAction func lawButtonPressed(_ sender: UIButton) {
		print("starting")
		//let allStops = getStopDictionary()
		//let allRoutes = getRouteDictionary()
		
		let tempRoute = "4005594" //route_id of Law Express
		let tempStops = "4068278%2C4068938%2C4068942%2C4068950%2C4068934%2C4068926" //all stops for Law Express
		let allEstimatedArrivals = getEstimatedArrivalsDictionary(routes: tempRoute, stops: tempStops)
		print(allEstimatedArrivals)
		routeID = "4005594"
		print("done")
		let array = (allEstimatedArrivals["data"]! as! NSArray).mutableCopy() as! NSMutableArray
		print(array)
		let json = JSON(NSValue.self)
		let numberOfStops = json["stop_id"].count
		print(numberOfStops)
		for index in 0..<numberOfStops {
			let stop_id = json["data"][index]["stop_id"].stringValue
				print("🙃🙃\(stop_id)")
			let arrival_at = json["data"][index]["arrivals"][index]["arrival_at"].stringValue
			let vehicle_id = json["data"][index]["arrivals"][index]["vehicle_id"].stringValue
			}
		
//		let result : [String: Any] = allEstimatedArrivals
//
//		if let stop_id = result["stop_id"] as? String {
//			print("🙃🙃🙃\(stop_id)")
		//}
	
	}
	
	@IBAction func groceryButtonPressed(_ sender: UIButton) {
		showAlert(title: "Bus Route Unavailable", message: "This bus route is currently not available.")
	
	}
	
	@IBAction func otherBusButtonPressed(_ sender: UIButton) {
		showAlert(title: "Bus Route Unavailable", message: "This bus route is currently not available.")
	}
	
	
}

