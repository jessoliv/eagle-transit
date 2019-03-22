//
//  SpecificRouteViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/26/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SpecificRouteViewController: UIViewController {
	
	@IBOutlet weak var userClosestLocationLabel: UILabel!
	@IBOutlet weak var userClosestLocationImage: UIImageView!
	@IBOutlet weak var estimatedArrivalBusLabel: UILabel!
	@IBOutlet weak var busMap: MKMapView!
	
	var currentPage = 0
	var navigationTitleLabel = ""
	var userLocationManager: CLLocationManager!
	var userCurrentlocation: CLLocation!
	let newPin = MKPointAnnotation()
	let newerPin = MKPointAnnotation()
	var route = ""
//	var stops: [String] = []
	var closestStop: Stop!
//	var arrivalTimes: [String] = []
	
	var busData = BusData()
	
	var busDetails: BusDetails!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = navigationTitleLabel
		print(navigationTitleLabel)
		
		print("🤯🤯🤯🤯🤯")
		
		
//		busDetails.getBusData(route_id: String) {
//			print("called getBusData")
//			//estimatedArrivalBusLabel.text =
//		}
		
		//estimatedArrivalBusLabel.text = responds[]
		
		//changeArrivalLabel()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if currentPage == 0 {
			getUserLocation()
		}
		
		
	}
		
	
	
	
	@IBAction func unwindFromSpecificRouteVC(segue: UIStoryboardSegue) {
		let source = segue.source as! SpecificRouteViewController
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destination = segue.destination as! StopsViewController
		if segue.identifier == "ShowAllStops" {
			switch navigationTitleLabel {
			case "Comm Ave All Stops":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Comm Ave All Stops"
				destination.stopsArray = ["Conte Forum", "McElroy", "College Road", "Main Gate - Chestnut Hill", "Cemetery - Greycliff Rd (Outbound)", "Reservoir Apartments", "Reservoir T Stop", "Bank of America", "Chiswick Rd", "Commonwealth Ave @ Chestnut Hill Ave", "South Street", "Greycliff Rd (Inbound)", "Robsham Theater"]
			case "Comm Ave Direct":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Comm Ave Direct Stops"
				destination.stopsArray = ["Conte Forum", "Cemetery - Greycliff Rd (Outbound)", "Reservoir Apartments", "Reservoir T Stop", "Bank of America", "Chiswick Rd", "Commonwealth Ave @ Chestnut Hill Ave", "South Street", "Greycliff Rd (Inbound)", "Robsham Theater"]
			case "Comm Ave Direct Express":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Comm Ave Direct Express Stops"
				destination.stopsArray = ["Conte Forum", "Cemetery - Greycliff Rd (Outbound)", "Reservoir Apartments", "Reservoir T Stop", "Bank of America", "Chiswick Rd", "Commonwealth Ave @ Chestnut Hill Ave", "South Street", "Greycliff Rd (Inbound)"]
			case "Newton Eagle All Stops":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Newton Eagle All Stops"
				destination.stopsArray = ["Stuart", "Main Gate - Newton Campus", "Main Gate - Chestnut Hill", "Robsham Theater", "Conte Forum", "McElroy", "College Road", "Duchesne"]
			case "Newton Eagle Direct":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Newton Eagle Direct Stops"
				destination.stopsArray = ["Stuart", "Main Gate - Newton Campus", "Main Gate - Chestnut Hill"]
			case "Newton Eagle Limited":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Newton Eagle Limited Stops"
				destination.stopsArray = ["Stuart", "Main Gate - Newton Campus", "Main Gate - Chestnut Hill", "McElroy", "College Road", "Duchesne"]
			case "Brighton Shuttle":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Brighton Shuttle Stops"
				destination.stopsArray = ["School of Theology & Ministry", "129 Lake Street", "St. Clements", "Greycliff Rd (Inbound)", "St. Ignatius Church", "University Health Services", "Conte Forum", "McElroy", "Main Gate - Chestnut Hill", "Brighton Dance Studio"]
			case "Law School Shuttle":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Law School Shuttle Stops"
				destination.stopsArray = ["Stuart", "Reservoir T Stop", "Bank of America", "Commonwealth Ave @ Chestnut Hill Ave", "South Street", "Greycliff Rd (Inbound)"]
			case "Grocery Shuttle":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Grocery Shuttle Stops"
				destination.stopsArray = ["Bus stops not available at this time"]
			case "Other Bus Routes":
				let destination = segue.destination as! StopsViewController
				destination.navigationTitleLabel = "Other Stops"
				destination.stopsArray = ["Bus stops not available at this time"]
			default:
				print("ERROR")
				}
			} else {
				print("ERROR: Array not updated")
			}
		}
	
	
//	func changeArrivalLabel() {
//		var nearStop = ""
//		switch userClosestLocationLabel.text {
//		case "College Road":
//			nearStop = "4068918"
//		default:
//			print("***")
//		}
	
	//}

}

// Retrieving User Location
extension SpecificRouteViewController: CLLocationManagerDelegate {
	
	func getUserLocation() {
		userLocationManager = CLLocationManager()
		userLocationManager.delegate = self
		let status = CLLocationManager.authorizationStatus()
		handleUserLocationAuthorizationStatus(status: status)
	}
	
	func handleUserLocationAuthorizationStatus(status: CLAuthorizationStatus) {
		switch status {
		case .notDetermined:
			userLocationManager.requestWhenInUseAuthorization()
		case .authorizedAlways, .authorizedWhenInUse:
			userLocationManager.requestLocation()
		case .denied:
			print("I'm sorry - can't show location. User has not authorized it.")
		case .restricted:
			print("Access denied. Likely parental controls are restricting location services in this app.")
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		handleUserLocationAuthorizationStatus(status: status)
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userCurrentlocation = locations.last
		closestStop = Stops.closestLocation(routeID: routeID, currentLocation: userCurrentlocation)
		print("🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸")
		print(closestStop)
		print(closestStop.name)
		userClosestLocationLabel.text = closestStop.name
		
		
		print(busDetails.results.count)
		for index in 0..<busDetails.results.count {
			//print(busDetails.results[index])
			var time = ""
			if busDetails.results[index].stop_id == closestStop.stopID {
				time = busDetails.results[index].arrival_at
				let formatter = ISO8601DateFormatter()
				let date = formatter.date(from: time)
				let timestamp = (ISO8601DateFormatter().date(from: time)!.timeIntervalSince1970) - Date().timeIntervalSince1970
//				formatter.formatOptions = [.withTime]
//				formatter.timeZone = TimeZone(abbreviation: "EST")
				let min = Date(timeIntervalSince1970: timestamp)
				
//				Calendar.current.dateComponents([.minute], from: Date(), to: timestamp).minute ?? 0
				print("🐳")
//				print(min)
				
				//var currentTime = Calendar.current.dateComponents([.minute], from: Date(), to: time).minute ?? 0
				print("👊")
				print(timestamp)
				
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "mm"
				let newMin = dateFormatter.string(from: min)
				print(newMin)
				//print(currentTime)
				estimatedArrivalBusLabel.text = "\(newMin) min"
			} else {
				//print("😎 LABEL NOT WORKING")
			}
		}
		
		switch closestStop.name {
		case "Newton Main Gate":
			userClosestLocationImage.image = UIImage(named: "newtonmain.jpg")
		case "Main Gate Chestnut Hill":
			userClosestLocationImage.image = UIImage(named: "Main Gate - Chestnut Hill.jpg")
		case "Robsham Theater":
			userClosestLocationImage.image = UIImage(named: "Robsham.jpg")
		case "Conte Forum":
			userClosestLocationImage.image = UIImage(named: "Conte Forum.jpg")
		case "McElroy":
			userClosestLocationImage.image = UIImage(named: "McElroy.jpg")
		case "College Road":
			userClosestLocationImage.image = UIImage(named: "collegeroad.jpg")
		case "Cemetary - Greycliff Rd (Outbound)":
			userClosestLocationImage.image = UIImage(named: "greycliff-cemetery")
		case "Greycliff Rd (Inbound)":
			userClosestLocationImage.image = UIImage(named: "greycliff.jpg")
		case "South Street":
			userClosestLocationImage.image = UIImage(named: "south.jpg")
		case "Reservoir T":
			userClosestLocationImage.image = UIImage(named: "reservoirt.jpg")
		case "Bank of America":
			userClosestLocationImage.image = UIImage(named: "bankofamerica.jpg")
		case "Chiswick Rd":
			userClosestLocationImage.image = UIImage(named: "chiswick.jpg")
		case "Chestnut Hill Ave":
			userClosestLocationImage.image = UIImage(named: "chestnuthill.jpg")
		case "Stuart":
			userClosestLocationImage.image = UIImage(named: "stuart.jpg")
		case "Duchesne":
			userClosestLocationImage.image = UIImage(named: "duchesne.jpg")
		case "St. Ignatius Gate":
			userClosestLocationImage.image = UIImage(named: "ignatius.jpg")
		case "School of Theology & Ministry Library":
			userClosestLocationImage.image = UIImage(named: "theology.jpg")
		case "St. Clements":
			userClosestLocationImage.image = UIImage(named: "clements.jpg")
		case "University Health Services":
			userClosestLocationImage.image = UIImage(named: "health.jpg")
		case "Conte Forum Gate A (Beacon St. Side)":
			userClosestLocationImage.image = UIImage(named: "ConteA.jpg")
		case "129 Lake Street":
			userClosestLocationImage.image = UIImage(named: "lakestreet.jpg")
		default:
			userClosestLocationImage.image = UIImage(named: "bc.png")
			print("ERROR: images failed to update")
		}
		
		
		let userCurrentLatitude = userCurrentlocation.coordinate.latitude
		let userCurrentLongitude = userCurrentlocation.coordinate.longitude
		let userCurrentCoordinates = "\(userCurrentLatitude), \(userCurrentLongitude)"
		print(userCurrentCoordinates)
		
		if let userLocation = locations.last{
			let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
			let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
			let location = locations.last! as CLLocation
			self.busMap.setRegion(region, animated: true)
			newPin.coordinate = location.coordinate
			self.busMap.addAnnotation(newPin)
			newPin.title = "My Location"
		}
		
		var closestStopLat = closestStop.latitude
		var closestStopLong = closestStop.longitude
		
		let centerStop = CLLocationCoordinate2D(latitude: closestStopLat, longitude: closestStopLong)
		let regionStop = MKCoordinateRegion(center: centerStop, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		let locationStop = locations.last! as CLLocation
		self.busMap.setRegion(regionStop, animated: true)
		newerPin.coordinate = centerStop
		self.busMap.addAnnotation(newerPin)
		newerPin.title = closestStop.name
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Failed to get user location.")
	}
	
}
