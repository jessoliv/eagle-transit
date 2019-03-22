//
//  AccessData.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/29/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



//created a global variable for a bus dictionary so i can access its contents from outside the 'task' variable in the below function
var busDictionary:Dictionary<String, Any> = [:]
//takes an api endpoint as a paramater and accesses its contents to make available to us outside this function
func buildBusDictionary(todoEndpoint: String) -> Dictionary<String, Any> {
	//API key from the 'Eagle Bus' X-Mashape-Key
	let apiKey = "DefVePm8dSmshugSSEyL48AL8OYtp1gZaGljsnJQYCwGObcTnL"
	//is the paramater a real URL?
	guard let url = URL(string: todoEndpoint) else {
		print("Error: cannot create URL")
		return [:]
	}
	//create the curl request - using a get method, introducing our api key, and informing the header we're returning json content
	var urlRequest = URLRequest(url: url)
	urlRequest.httpMethod = "GET"
	urlRequest.addValue(apiKey, forHTTPHeaderField: "x-mashape-key")
	urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
	let session = URLSession.shared
	
	//reference for dispatches: http://jordansmith.io/dispatch-groups-in-swift-3/
	//i need to be positive the task is fully completed before i try to access the json data
	let dispatchGroup = DispatchGroup()
	dispatchGroup.enter()
	
	//finally accessing the json data and saving its contents to a dictionary we can read from
	let task = session.dataTask(with: urlRequest) {
		(data, response, error) in
		//check for any errors
		guard error == nil else {
			print("error calling GET on /todos/1")
			print(error!)
			return
		}
		//make sure we have data
		guard let responseData = data else {
			print("Error: did not receive data")
			return
		}
		//parse the result as JSON, since that's what the API provides
		do {
			guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
				as? [String: Any] else {
					print("error trying to convert data to JSON")
					return
			}
			busDictionary = todo // self. ??
			
		} catch  {
			print("error trying to convert data to JSON")
			return
		}
		//leaving the dispatch since the task has completed
		dispatchGroup.leave()
	}
	//run the task
	task.resume()
	//wait until task is completed
	dispatchGroup.wait()
	//return a information-flled dictionary for our use
	return busDictionary
}

//building the API URL endpoint based on the info we need and sending to Swift Curl request
func getStopDictionary() -> Dictionary<String, Any> {
	let query = "stops"
	let agencyID = "32"
	let todoEndpoint: String = "https://transloc-api-1-2.p.mashape.com/" + query + "?agencies=" + agencyID + "&callback=call"
	return buildBusDictionary(todoEndpoint: todoEndpoint)
}

//building the API URL endpoint based on the info we need and sending to Swift Curl request
func getRouteDictionary() -> Dictionary<String, Any> {
	let query = "routes"
	let agencyID = "32"
	let todoEndpoint: String = "https://transloc-api-1-2.p.mashape.com/" + query + "?agencies=" + agencyID + "&callback=call"
	return buildBusDictionary(todoEndpoint: todoEndpoint)
}

//building the API URL endpoint based on the info we need and sending to Swift Curl request
func getEstimatedArrivalsDictionary(routes: String, stops: String) -> Dictionary<String, Any> {
	let query = "arrival-estimates"
	let agencyID = "32"
	let todoEndpoint: String = "https://transloc-api-1-2.p.mashape.com/" + query + "?agencies=" + agencyID + "&callback=call&routes=" + routes + "&stops=" + stops
	// let routes = dictionary["routes"] as? String? ?? ""
	let route = routes
	let stop = stops
	print("🦅🦅🦅🦅🦅")
	print("***** route = \(route)")
	print("***** stop = \(stop)")
	print(todoEndpoint)
	return buildBusDictionary(todoEndpoint: todoEndpoint)
}
	
//	let json = JSON(NSValue.self)
//	let numberOfStops = json["results"].count
	
//	for index in 0..<numberOfStops {
////		let stop_id = json["data"][index]["stop_id"].stringValue
////		print(stop_id)
////		let arrival_at = json["data"][index]["arrivals"][index]["arrival_at"].stringValue
////		let vehicle_id = json["data"][index]["arrivals"][index]["vehicle_id"].stringValue
//	}




