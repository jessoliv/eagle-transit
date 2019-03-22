//
//  Stop.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/30/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import SwiftyJSON

var routeID = ""

struct Stop {
	var name: String
	var stopID: String
	var routes: [String]
	var longitude: Double
	var latitude: Double
	
	// stop location
	var location: CLLocation {
		return CLLocation(latitude: latitude, longitude: longitude)
	}
}

struct Stops {
	static func allStops() -> [Stop] {
		return [
			Stop(name: "Newton Main Gate", stopID: "4068278", routes: ["4005598",
				"4005602",
				"4005606"], longitude: -71.192625, latitude: 42.341653),
			
			Stop(name: "Main Gate Chestnut Hill", stopID: "4068902", routes: ["4005570", "4005574", "4005598", "4005602", "4005606"], longitude: -71.171094, latitude: 42.337928),
			
			Stop(name: "Robsham Theater", stopID: "4068906", routes: ["4005574","4005578","4005598"], longitude: -71.169006, latitude: 42.337958),
			
			Stop(name: "Conte Forum", stopID: "4068910", routes: ["4005574",
				 "4005578","4005582","4005598"], longitude: -71.167308, latitude: 42.335892),
			
			Stop(name: "McElroy", stopID: "4068914", routes: [
				"4005570", "4005574", "4005598", "4005606"], longitude: -71.170842, latitude: 42.333167),
			
			Stop(name: "College Road", stopID: "4068918", routes: [
				"4005574", "4005598", "4005606"], longitude: -71.1716, latitude: 42.335236),
		
			Stop(name: "Cemetery - Greycliff Rd (Outbound)", stopID: "4068922", routes: ["4005574","4005578", "4005582"], longitude: -71.161117, latitude: 42.339881),
			
			Stop(name: "Greycliff Rd (Inbound)", stopID: "4068926", routes: ["4005570","4005574","4005578","4005594"], longitude: -71.161239, latitude: 42.340219),
			
			Stop(name: "Reservoir Apartments", stopID: "4068930", routes: ["4005574","4005578","4005582"], longitude: -71.1589, latitude: 42.339689),
			
			Stop(name: "South Street", stopID: "4068934", routes: ["4005574","4005578","4005582","4005594"], longitude: -71.157561, latitude: 42.33965),
			
			Stop(name: "Reservoir T", stopID: "4068938", routes: ["4005574","4005578","4005582","4005594"], longitude: -71.148925, latitude: 42.334939),
			
			Stop(name: "Bank of America", stopID: "4068942", routes: ["4005574","4005578","4005582","4005594"], longitude: -71.152023, latitude: 42.336955),
			
			Stop(name: "Chiswick Rd", stopID: "4068946", routes: ["4005574","4005578","4005582"], longitude: -71.151311, latitude: 42.340525),
			
			Stop(name: "Chestnut Hill Ave", stopID: "4068950", routes: ["4005574","4005578","4005582","4005594"], longitude: -71.153975, latitude: 42.338203),
			
			Stop(name: "Stuart", stopID: "4160230", routes: ["4005594","4005598","4005602","4005606"], longitude: -71.193875, latitude: 42.341133),
			
			Stop(name: "Duchesne", stopID: "4160234", routes: ["4005598","4005606"], longitude: -71.192611, latitude: 42.343467),
			
			Stop(name: "St. Ignatius Gate", stopID: "4160246", routes: ["4005570"], longitude: -71.16667, latitude: 42.339515),
			
			Stop(name: "School of Theology & Ministry Library", stopID: "4191290", routes: ["4005570"], longitude: -71.1631, latitude: 42.3418),
			
			Stop(name: "St. Clements", stopID: "4197490", routes: ["4005570"], longitude: -71.15809, latitude: 42.34379),
			
			Stop(name: "University Health Services", stopID: "4211340", routes: ["4005570"], longitude: -71.1646, latitude: 42.3394),
			
			Stop(name: "Conte Forum Gate A (Beacon St. Side)", stopID: "4211342", routes: ["4005570"], longitude: -71.1676, latitude: 42.3343),
			
			Stop(name: "129 Lake Street", stopID: "4211344", routes: ["4005570"], longitude: -71.161633, latitude: 42.343392),
			
		]

	}
	
	static func stopsForRoute(routeID: String) -> [Stop] {
		let stops = allStops()
		var stopsForRoute = [Stop]()
		for stop in stops {
			if stop.routes.contains(routeID) {
				stopsForRoute.append(stop)
			}
		}
		return stopsForRoute
	}
	
	static func closestLocation(routeID: String, currentLocation: CLLocation) -> Stop {
		let stops = stopsForRoute(routeID: routeID)
		var closestStop: Stop?
		var smallestDistance: CLLocationDistance = Double(Int.min)

		for stop in stops {
			let distance = currentLocation.distance(from: stop.location)
			if smallestDistance == Double(Int.min) || distance < smallestDistance {
				closestStop = stop
				smallestDistance = distance
			}
		}
		return closestStop!
	}
}


