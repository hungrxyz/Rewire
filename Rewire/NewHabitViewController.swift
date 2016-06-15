//
//  NewHabitViewController.swift
//  Rewire
//
//  Created by Zel Marko on 5/27/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import MBProgressHUD

class NewHabitViewController: UIViewController, TwitterAccountIDConstructable {
	
	@IBOutlet weak var newHabitNameLabel: UILabel!
	@IBOutlet weak var newHabitNameTextField: UITextField!
	@IBOutlet weak var linkTwitterAccountSwitch: UISwitch!
	@IBOutlet weak var useTo_dayDataSwitch: UISwitch!
	@IBOutlet weak var useWorkHDataSwitch: UISwitch!
	@IBOutlet weak var notificationsSwitch: UISwitch!
	@IBOutlet weak var startNewHabitButton: UIButton!
	@IBOutlet weak var customTextField: UITextField!
	@IBOutlet weak var customTextFieldAbbr: UITextField!
	@IBOutlet weak var scrollView: UIScrollView!
	
	var twitterAccountID: TwitterAccountID?
	
	var keyboardShown = false
	var lastActiveTextField: UITextField?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor(patternImage: UIImage(named: "AppIcon60x60")!)
		
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(keyboardWillShow(_:)),
		                                                 name: UIKeyboardWillShowNotification,
		                                                 object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(keyboardWillHide(_:)),
		                                                 name: UIKeyboardWillHideNotification,
		                                                 object: nil)
		NSNotificationCenter.defaultCenter().addObserver(self,
		                                                 selector: #selector(keyboardFrameDidChange(_:)),
		                                                 name: UIKeyboardDidChangeFrameNotification,
		                                                 object: nil)
		
		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewWasTapped))
		view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@IBAction func startNewHabitButtonTapped(sender: AnyObject) {
		HUD.sharedInstance.showWithText("Setting up " + newHabitNameTextField.text!)
		
		performSegueWithIdentifier("toMainSegue", sender: self)
		
		let newHabit = Habit(name: newHabitNameTextField.text!,
		                     twitterAccountId: twitterAccountID?.id,
		                     useTo_dayData: useTo_dayDataSwitch.on,
		                     useWorkHData: useWorkHDataSwitch.on,
		                     notifications: false,
		                     tasks: nil)
		
		CKHandler.sharedInstance.newHabit(newHabit)
	}
	
	@IBAction func linkTwitterAccountSwitchValueChanged(sender: UISwitch) {
		if sender.on {
			getTwitterAccountID { twitterAccountID in
				if let twitterAccountID = twitterAccountID {
					self.twitterAccountID = twitterAccountID
				}
			}
		} else {
			twitterAccountID = nil
		}
	}
	
	@IBAction func useTo_dayDataSwitchValueChanged(sender: UISwitch) {
		if sender.on {
			HUD.sharedInstance.showWithText("Setting up To-day data")
			CKTo_dayDataHandler.sharedInstance.checkExistingTo_dayData()
		}
	}
	
	@IBAction func useWorkHDataSwitchValueChanged(sender: UISwitch) {
		if sender.on {
			HUD.sharedInstance.showWithText("Setting up WorkH data")
			CKWorkHDataHandler.sharedInstance.checkExistingWorkHData()			
		}
	}
	
	@IBAction func notificationsSwitchValueChanged(sender: UISwitch) {
		
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
	
	func keyboardWillShow(notification: NSNotification) {
		adjustScrollViewInsetForKeyboardAction(true, change: nil, notification: notification)
		keyboardShown = true
	}
	
	func keyboardWillHide(notification: NSNotification) {
		adjustScrollViewInsetForKeyboardAction(false, change: nil, notification: notification)
		keyboardShown = false
	}
	
	func keyboardFrameDidChange(notification: NSNotification) {
		adjustScrollViewInsetForKeyboardAction(nil, change: true, notification: notification)
	}
	
	func adjustScrollViewInsetForKeyboardAction(show: Bool?, change: Bool?, notification: NSNotification) {
		guard let value = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
		let keyboardFrame = value.CGRectValue()
		var adjustmentHeight: CGFloat!
		if let show = show {
			adjustmentHeight = CGRectGetHeight(keyboardFrame) * (show ? (keyboardShown ? 0 : 1) : -1)
		} else if let _ = change {
			adjustmentHeight = CGRectGetHeight(keyboardFrame) - scrollView.contentInset.bottom
		}
		
		scrollView.contentInset.bottom += adjustmentHeight
		scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
	}
	
	func viewWasTapped() {
		if let textField = lastActiveTextField {
			textField.resignFirstResponder()
		}
	}
}

extension NewHabitViewController: UITextFieldDelegate {
	
	func textFieldDidBeginEditing(textField: UITextField) {
		lastActiveTextField = textField
		
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
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
