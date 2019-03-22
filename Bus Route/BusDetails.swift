//
//  BusDetails.swift
//  
//
//  Created by Jessica Olivieri on 12/3/18.
//

import Foundation
import Alamofire
import SwiftyJSON


class BusDetails {
	
	struct BusInfo {
		var stop_id = ""
		var route_id = ""
		var vehicle_id = ""
		var arrival_at = ""
	}
	
	var results: [BusInfo] = []
	var savedStops: [StopInfo] = []
	

	
	
	func getBusData(route_id: String, completed: @escaping () -> () ) {
		
		let url = ("https://transloc-api-1-2.p.mashape.com/arrival-estimates.json?agencies=32&callback=call&routes=\(route_id)&stops=4068278%2C4068902%2C4068906%2C4068910%2C4068914%2C4068918%2C4068922%2C4068926%2C4068930%2C4068922%2C4068934%2C4068938%2C4068942%2C4068946%2C4068950%2C4114694%2C4160230%2C4160234%2C4160238%2C4160242%2C4160246%2C4160250%2C4173268%2C4173270%2C4173272%2C4191290%2C4197490%2C4211340%2C4211342%2C4211344")
		
		let headers: HTTPHeaders = [
			"X-Mashape-Key":"DefVePm8dSmshugSSEyL48AL8OYtp1gZaGljsnJQYCwGObcTnL",
			"Content-Type": "application/json"
		]
			
//		let parameters: Parameters = [
//			"agencies": "32",
//			"callback": "call",
//			"routes": "4005598%2C4005602%2C4005606%2C4005574%2C4005578%2C4005582%2C4005570%2C4005594",
//			"stops": "4068278%2C4068902%2C4068906%2C4068910%2C4068914%2C4068918%2C4068922%2C4068926%2C4068930%2C4068922%2C4068934%2C4068938%2C4068942%2C4068946%2C4068950%2C4114694%2C4160230%2C4160234%2C4160238%2C4160242%2C4160246%2C4160250%2C4173268%2C4173270%2C4173272%2C4191290%2C4197490%2C4211340%2C4211342%2C4211344"
//
//		]
		
		Alamofire.request(url,method: .get, headers: headers).response { response in
//			print(response.response)
			
			if let data = response.data, let result = String(data:data, encoding: .utf8){
//				print("Data: \(result)")
				let json = JSON(parseJSON: result)
				print(json["data"])
				for index in 0..<json["data"].count{
					let element = json["data"][index]
					print(element)
					self.results.append(BusInfo(stop_id: element["stop_id"].stringValue, route_id: "", vehicle_id: "", arrival_at: element["arrivals"][0]["arrival_at"].stringValue))
//					self.results.stop_id.append(element["stop_id"].stringValue)
//					arrival_at.append(element["arrivals"][0]["arrival_at"].stringValue)
//					self
				}
				//print(self.stop_id)
			}
//				let result = response.result
//				print(result)
			
//				switch response.result {
//				case .success(let value):
//					let json = JSON(value)
//					self.stop_id = json["stop_id"].stringValue
//					self.route_id = json["route_id"].stringValue
//					self.vehicle_id = json["vehicle_id"].stringValue
//					self.arrival_at = json["arrival_at"].stringValue
//				case .failure(let error):
//					print("ERROR")
//				}
				completed()
		}
		
	}
	
}


