//
//  AllRequestedStopsViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 12/3/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit

class AllRequestedStopsViewController: UIViewController {
	
	@IBOutlet weak var stopsTableView: UITableView!
	
	var busDetails: BusDetails!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		stopsTableView.delegate = self
		stopsTableView.dataSource = self
		

    }

}

extension AllRequestedStopsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return busDetails.savedStops.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = busDetails.savedStops[indexPath.row].stopName
		cell.detailTextLabel?.text = busDetails.savedStops[indexPath.row].busNumber
		return cell
	}
	
	
}
