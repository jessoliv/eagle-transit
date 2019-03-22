//
//  HoursViewController.swift
//  Bus Route
//
//  Created by Jessica Olivieri on 11/26/18.
//  Copyright © 2018 Jessica Olivieri. All rights reserved.
//

import UIKit

class HoursViewController: UIViewController {
	
	var navigationTitleLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = navigationTitleLabel
		print(navigationTitleLabel)

    }
	
	@IBAction func unwindFromSpecificRouteVC(segue: UIStoryboardSegue) {
		let source = segue.source as! HoursViewController
	}

}
