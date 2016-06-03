//
//  NewHabitViewController.swift
//  Rewire
//
//  Created by Zel Marko on 5/27/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewHabitViewController: UIViewController {
	
	@IBOutlet weak var newHabitNameLabel: UILabel!
	@IBOutlet weak var newHabitNameTextField: UITextField!
	@IBOutlet weak var startNewHabitButton: UIButton!
	@IBOutlet weak var customTextField: UITextField!
	@IBOutlet weak var customTextFieldAbbr: UITextField!
	
	var twitterHandler: TwitterHandler!
	
	var twitterAccountId: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		twitterHandler = TwitterHandler()
		
		view.backgroundColor = UIColor(patternImage: UIImage(named: "AppIcon60x60")!)
	}
	
	@IBAction func startNewHabitButtonTapped(sender: AnyObject) {
		
	}
	
	@IBAction func linkTwitterAccountSwitchValueChanged(sender: UISwitch) {
		if sender.on {
			twitterHandler.setup { accountId in
				self.twitterAccountId = accountId
				if accountId == nil {
					dispatch_async(dispatch_get_main_queue()) {
						sender.on = false
					}
				}
			}
		}
	}
	
	@IBAction func useTo_dayDataSwitchValueChanged(sender: AnyObject) {
			
	}
	
	@IBAction func useWorkHDataSwitchValueChanged(sender: AnyObject) {
		
	}
	
	@IBAction func notificationsSwitchValueChanged(sender: AnyObject) {
		
	}
	
	@IBAction func habitNameTextFieldEditingChanged(textField: UITextField) {
		if textField.text == "Habit Name" || textField.text == "" {
			startNewHabitButton.enabled = false
			startNewHabitButton.alpha = 0.5
		} else {
			startNewHabitButton.enabled = true
			startNewHabitButton.alpha = 1
		}
	}
}

extension NewHabitViewController: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(textField: UITextField) {
		if textField == customTextField && textField.text == "Custom" {
			textField.text = ""
			textField.alpha = 1
		} else if textField == customTextFieldAbbr && textField.text == "Abbr." {
			textField.text = ""
			textField.alpha = 1
		} else if textField == newHabitNameTextField && textField.text == "Habit Name" {
			textField.text = ""
			textField.alpha = 1
		}
	}
	
	func textFieldDidEndEditing(textField: UITextField) {
		if textField == customTextField && textField.text == "" {
			textField.text = "Custom"
			textField.alpha = 0.5
		} else if textField == customTextFieldAbbr && textField.text == "" {
			textField.text = "Abbr."
			textField.alpha = 0.5
		} else if textField == customTextFieldAbbr && textField.text == "" {
			textField.text = "Habit Name"
			textField.alpha = 0.5
		}
	}
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		
		if textField == customTextFieldAbbr && textField.text?.characters.count >= 4 && string != "" {
			return false
		}
		return true
	}
}
