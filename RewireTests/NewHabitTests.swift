//
//  NewHabitTests.swift
//  Rewire
//
//  Created by Zel Marko on 5/29/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
import MBProgressHUD
@testable import Rewire

class NewHabitTests: XCTestCase {
	
	var newHabitViewController: NewHabitViewController!
	
	override func setUp() {
		super.setUp()
		
		newHabitViewController = UIStoryboard(name: "NewHabit", bundle: nil).instantiateInitialViewController() as! NewHabitViewController
		
		_ = newHabitViewController.view
		
		
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testIfButtonEnabledCorrectly() {
		XCTAssert(newHabitViewController.startNewHabitButton.enabled == false, "Start New Habit button shouldn't be enabled")
		
		newHabitViewController.newHabitNameTextField.text = "New habit name"
		textFieldTextDidChange()
		XCTAssert(newHabitViewController.startNewHabitButton.enabled, "Start New Habit button shouldn't be disabled")
		
		newHabitViewController.newHabitNameTextField.text = ""
		textFieldTextDidChange()
		XCTAssert(newHabitViewController.startNewHabitButton.enabled == false, "Start New Habit button shouldn't be enabled")
	}
	
	func testIfProgressHUDIsShown() {
		newHabitViewController.startNewHabitButton.enabled = true
		newHabitViewController.startNewHabitButtonTapped(newHabitViewController)
		
		XCTAssertTrue(newHabitViewController.view.subviews.contains { $0.isKindOfClass(MBProgressHUD) },
		              "MBProgressHUD is not one of views subvies")
	}
	
	func textFieldTextDidChange() {
		newHabitViewController.textField(newHabitViewController.newHabitNameTextField, shouldChangeCharactersInRange: NSRange(), replacementString: "")
	}
	
	func testSwitchesAreFunctional() {
		newHabitViewController.startNewHabitButton.enabled = true
		newHabitViewController.startNewHabitButtonTapped(newHabitViewController)
		
		
	}
}
