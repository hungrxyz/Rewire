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
	@IBOutlet weak var scrollView: UIScrollView!
	
	var twitterHandler: TwitterHandler!
	
	var twitterAccountId: String?
	
	var keyboardShown = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		twitterHandler = TwitterHandler()
		
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
	
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
