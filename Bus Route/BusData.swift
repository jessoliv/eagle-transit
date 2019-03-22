//
//  BusData.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 12/1/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BusData {
	var url = ""
	var route_id = ""
	var vehicle_id = ""
	var arrival_at = ""
	var stop_id = ""
	
	func getBusData(completed: @escaping () -> () ) {
		let url = "https://market.mashape.com/transloc/openapi-1-2#arrival-estimates"
		Alamofire.request(url).responseJSON { response in
			switch response.result {
			case .success(let value):
				let json = JSON(value)
				print("🇺🇸🇺🇸🇺🇸 json = ", json)
				self.route_id = json["data"][0]["arrivals"][0]["route_id"].stringValue
				print("😎😎 self.rout_id is = \(self.route_id)")
			case .failure(let error):
				print("😡😡😡 *** error getting data from \(url) and \(error.localizedDescription)")
			}
			completed()
		}
	}
}
