//
//  StopsViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/27/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit

class StopsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var stopsArray = ["Chestnut Hill Ave", "Conte Forum"]
	

	var navigationTitleLabel = ""
	
	override func viewDidLoad() {
        super.viewDidLoad()
	
		navigationItem.title = navigationTitleLabel
		print(navigationTitleLabel)
		var newTitle = navigationItem.title
		
		tableView.delegate = self
		tableView.dataSource = self
		

    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier ?? "" {
		case "ShowCellRequest":
			let destination = segue.destination as! RequestStopVC
			destination.busStopsArray = stopsArray
			
		case "ShowRequestStop":
			let destination = segue.destination as! RequestStopVC
			destination.busStopsArray = stopsArray
			
		default:
			print("ERROR: PickerView not updated")
		}
	}
	
	@IBAction func unwindFromStopsVC(segue: UIStoryboardSegue) {
		let source = segue.source as! StopsViewController
//		let destination = segue.destination as! RequestStopVC
//		for item in 0..<stopsArray.count {
//			if stopsArray[item].row == destination.stopTextField {
		
			//}
		//}
	}

	@IBAction func requestStopButtonPressed(_ sender: UIButton) {
	}
}

extension StopsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return stopsArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
		cell.textLabel?.text = stopsArray[indexPath.row]//.name // not sure if this is right
		return cell
	}
	
	func updateTable(stop: Stops){
		let newIndexPath = IndexPath(row: stopsArray.count, section: 0)
		// might not need this
		
	}
	
	
}
