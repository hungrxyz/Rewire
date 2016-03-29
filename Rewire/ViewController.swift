//
//  ViewController.swift
//  Rewire
//
//  Created by Zel Marko on 3/22/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var habitNameLabel: UILabel!
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var stageLabel: UILabel!
	@IBOutlet weak var percentageLabel: UILabel!
	
	var alert: UIAlertController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		checkDate()
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(didBecomeActive), name: UIApplicationDidBecomeActiveNotification, object: nil)
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		if let alert = alert {
			presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	func checkDate() {
		let userDefaults = NSUserDefaults.standardUserDefaults()
		if let startDate = userDefaults.valueForKey("startDate") as? NSDate, habitName = userDefaults.valueForKey("habitName") as? String {
			habitNameLabel.text = habitName
			percentage(startDate)
		} else {
			alert = UIAlertController(title: "✋", message: "No habit progress is being tracked,\nadd a new habit to start.", preferredStyle: .Alert)
			
			var habitTextField: UITextField!
			alert!.addTextFieldWithConfigurationHandler({ (textField) in
				textField.placeholder = "enter habit name"
				habitTextField = textField
			})
			
			alert!.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action) in
				userDefaults.setValue(NSDate(), forKey: "startDate")
				self.dayLabel.text = "\(NSDate())"
				if habitTextField.text!.isEmpty {
					userDefaults.setValue("Unknown Habit", forKey: "habitName")
					self.habitNameLabel.text = "Unknown Habit"
				} else {
					userDefaults.setValue(habitTextField.text!, forKey: "habitName")
					self.habitNameLabel.text = habitTextField.text!
				}
			}))
			
			alert!.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
		}
	}
	
	func percentage(date: NSDate) {
		let calendar = NSCalendar.currentCalendar()
		let difference = calendar.components([.Day], fromDate: date, toDate: NSDate(), options: [])
		dayLabel.text = (difference.day + 1).description
		switch difference.day + 1 {
		case 1...22:
			stageLabel.text = 1.description
		case 23...44:
			stageLabel.text = 2.description
		case 45...66:
			stageLabel.text = 3.description
		default:
			stageLabel.text = 4.description
		}
		
		let percentsFloat = (Float(difference.day + 1) / 66) * 100
		
		percentageLabel.text = "\(percentsFloat.description.substringToIndex(percentsFloat.description.startIndex.advancedBy(1)))"
	}
	
	func didBecomeActive() {
		checkDate()
	}
}


