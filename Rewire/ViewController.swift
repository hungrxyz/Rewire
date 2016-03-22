//
//  ViewController.swift
//  Rewire
//
//  Created by Zel Marko on 3/22/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		NSUserDefaults.standardUserDefaults().setValue(NSDate(), forKey: "startDate")
		print(NSUserDefaults.standardUserDefaults().valueForKey("startDate"))
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

