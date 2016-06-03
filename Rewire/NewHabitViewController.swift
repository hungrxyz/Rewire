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
	@IBOutlet weak var linkTwitterAccountSwitch: UISwitch!
	@IBOutlet weak var notificationsSwitch: UISwitch!
	@IBOutlet weak var useTo_dayDataSwitch: UISwitch!
	@IBOutlet weak var useWorkHDataSwitch: UISwitch!
	@IBOutlet weak var startNewHabitButton: UIButton!
	
	var twitterHandler: TwitterHandler!
	
	var twitterAccountId: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		twitterHandler = TwitterHandler()
		
		view.backgroundColor = UIColor(patternImage: UIImage(named: "AppIcon60x60")!)
	}
	
	@IBAction func startNewHabitButtonTapped(sender: AnyObject) {
		let newHabit = Habit()
		newHabit.name = newHabitNameTextField.text!
		
		RealmHandler.sharedInstance.addNewHabit(newHabit)
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
			print(textField.text)
			startNewHabitButton.enabled = false
			startNewHabitButton.alpha = 0.5
		} else {
			startNewHabitButton.enabled = true
			startNewHabitButton.alpha = 1
		}
	}
}

extension NewHabitViewController: UITextFieldDelegate {
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		return true
	}
}
