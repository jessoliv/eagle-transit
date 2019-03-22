//
//  PossibleRoutesViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/28/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit

class PossibleRoutesViewController: UIViewController {

	@IBOutlet weak var routeOneLabel: UIButton!
	@IBOutlet weak var routeTwoLabel: UIButton!
	@IBOutlet weak var routeThreeLabel: UIButton!
	@IBOutlet weak var townImage: UIImageView!
	
	
	var navigationTitleLabel = ""
	var routeLabelOne = ""
	var routeLabelTwo = ""
	var routeLabelThree = ""
	var showImage = ""
	
	var busData = BusData()
	var busDetails = BusDetails()

	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = navigationTitleLabel
		print(navigationTitleLabel)
		
		routeOneLabel.setTitle(routeLabelOne, for: .normal)
		routeTwoLabel.setTitle(routeLabelTwo, for: .normal)
		routeThreeLabel.setTitle(routeLabelThree, for: .normal)
		print(routeLabelOne)
		print(routeLabelTwo)
		print(routeLabelThree)
		
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier ?? "" {
		case "ShowRouteOne":
			let destination = segue.destination as! SpecificRouteViewController
			print("🍔🍔🍔")
			print(busDetails)
			destination.busDetails = busDetails
			if navigationTitleLabel == "Choose Comm Ave Bus" {
				destination.navigationTitleLabel = "Comm Ave All Stops"
			} else if navigationTitleLabel == "Choose Newton Bus Route" {
				destination.navigationTitleLabel = "Newton Eagle All Stops"
			} else {
				print("*** ERROR: ROUTE 1 - Navigation title did not change in SpecificRoutesVC")
			}
		case "ShowRouteTwo":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			if navigationTitleLabel == "Choose Comm Ave Bus" {
				destination.navigationTitleLabel = "Comm Ave Direct"
			} else if navigationTitleLabel == "Choose Newton Bus Route" {
				destination.navigationTitleLabel = "Newton Eagle Direct"
			} else {
				print("*** ERROR: ROUTE 2 - Navigation title did not change in SpecificRoutesVC")
			}
		case "ShowRouteThree":
			let destination = segue.destination as! SpecificRouteViewController
			destination.busDetails = busDetails
			if navigationTitleLabel == "Choose Comm Ave Bus" {
				destination.navigationTitleLabel = "Comm Ave Direct Express"
			} else if navigationTitleLabel == "Choose Newton Bus Route" {
				destination.navigationTitleLabel = "Newton Eagle Limited"
			} else {
				print("*** ERROR: ROUTE 3 - Navigation title did not change in SpecificRoutesVC")
			}
		default:
			print("*** ERROR: did not have a segue in SpotDetailViewController prepare(for: segue)")
		}
	}
	
//	@IBAction func unwindFromPossibleRtVC(segue: UIStoryboardSegue) {
//		let source = segue.source as! PossibleRoutesViewController
//	}
	
	@IBAction func routeOneButtonPressed(_ sender: UIButton) {
//		busData.getBusData {
//			print("** WE GOT DATA! \(self.busData.route_id) **")
//		}
		if navigationTitleLabel == "Choose Comm Ave Bus" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005574" //route_id of Comm Ave All Stops
			let tempStops = "4068910%2C4068914%2C4068918%2C4068902%2C4068922%2C4068930%2C4068938%2C4068942%2C4068946%2C4068950%2C4068934%2C4068926%2C4068906" //all stops for Comm Ave All Stops
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
				print(self.busDetails.results.count)
			}
			print("🏆🏆🏆")
			routeID = "4005574"
			print("done")
		} else if navigationTitleLabel == "Choose Newton Bus Route" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005598" //route_id of Newton Eagle All Stops
			let tempStops = "4068278%2C4160234%2C4160230%2C4068902%2C4068906%2C4068910%2C4068914%2C4068918" //all stops for Newton Eagle All Stops
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
			}
			routeID = "4005598"
			print("done")
			
		}
		
	}
	@IBAction func routeTwoButtonPressed(_ sender: UIButton) {
		if navigationTitleLabel == "Choose Comm Ave Bus" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005578" //route_id of Comm Ave Direct
			let tempStops = "4068910%2C4068922%2C4068930%2C4068938%2C4068942%2C4068946%2C4068950%2C4068934%2C4068926%2C4068906" //all stops for Comm Ave Direct
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
				print(self.busDetails.results)
			}
			print("🏆🏆🏆")
//			print(allEstimatedArrivals)
			routeID = "4005578"
			print("done")
		} else if navigationTitleLabel == "Choose Newton Bus Route" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005602" //route_id of Newton Eagle Direct
			let tempStops = "4068902%2C4068278%2C4160230" //all stops for Newton Eagle Direct ** havent updated yet!
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
			}
			routeID = "4005602"
			print("done")
			
		}
	}
	
	@IBAction func routeThreeButtonPressed(_ sender: UIButton) {
		if navigationTitleLabel == "Choose Comm Ave Bus" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005582" //route_id of Comm Ave Direct Express
			let tempStops = "4068910%2C4068922%2C4068930%2C4068938%2C4068942%2C4068946%2C4068950%2C4068934" //all stops for Comm Ave Direct Express
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
			}
			routeID = "4005582"
			print("done")
		} else if navigationTitleLabel == "Choose Newton Bus Route" {
			print("starting")
			//let allStops = getStopDictionary()
			//let allRoutes = getRouteDictionary()
			
			let tempRoute = "4005606" //route_id of Newton Eagle Limited
			let tempStops = "4068902%2C4068278%2C4160230%2C4160234%2C4068914%2C4068918" //all stops for Newton Eagle Direct ** havent updated yet!
			busDetails.getBusData(route_id: tempRoute) {
				print("finished getting bus data")
			}
			routeID = "4005606"
			print("done")
			
		}
	}
}
