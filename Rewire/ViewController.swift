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
		
		NSUserDefaults.standardUserDefaults().removeObjectForKey("startDate")
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if let startDate = NSUserDefaults.standardUserDefaults().valueForKey("startDate") {
			print(startDate)
		} else {
			let alert = UIAlertController(title: "✋", message: "No habit progress is being tracked,\nadd a new habit to start.", preferredStyle: .Alert)
			
			var habitTextField: UITextField!
			alert.addTextFieldWithConfigurationHandler({ (textField) in
				textField.placeholder = "enter habit name"
				habitTextField = textField
			})
			
			alert.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action) in
				NSUserDefaults.standardUserDefaults().setValue(NSDate(), forKey: "startDate")
				if habitTextField.text!.isEmpty {
					self.title = "Habit Name"
				} else {
					self.title = habitTextField.text!
				}
			}))
			
			alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
			
			presentViewController(alert, animated: true, completion: nil)
		}
	}


}

