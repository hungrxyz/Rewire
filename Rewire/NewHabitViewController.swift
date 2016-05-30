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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(patternImage: UIImage(named: "AppIcon60x60")!)
	}
	
	@IBAction func startNewHabitButtonTapped(sender: AnyObject) {
		let newHabit = Habit()
		newHabit.name = newHabitNameTextField.text!
		newHabit.linkTwitterAccount = linkTwitterAccountSwitch.on
		newHabit.notifications = notificationsSwitch.on
		newHabit.useTo_dayData = useTo_dayDataSwitch.on
		newHabit.useWorkHData = useWorkHDataSwitch.on
		
		RealmHandler.sharedInstance.addNewHabit(newHabit)
	}
	
	@IBAction func linkTwitterAccountSwitchValueChanged(sender: AnyObject) {
	}
	@IBAction func useTo_dayDataSwitchValueChanged(sender: AnyObject) {
	}
	@IBAction func useWorkHDataSwitchValueChanged(sender: AnyObject) {
	}
	@IBAction func notificationsSwitchValueChanged(sender: AnyObject) {
	}
}

extension NewHabitViewController: UITextFieldDelegate {
	
	func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
		if textField.text == "Habit Name" || textField.text == "" {
			startNewHabitButton.enabled = false
		} else {
			startNewHabitButton.enabled = true
		}
		return true
	}
}
