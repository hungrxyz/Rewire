//
//  NewHabitTests.swift
//  Rewire
//
//  Created by Zel Marko on 5/29/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
@testable import Rewire

class NewHabitViewControllerTests: XCTestCase {
	
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
	
	func test_startButton_enabledAccordingly() {
		XCTAssert(newHabitViewController.startNewHabitButton.enabled == false, "Start New Habit button shouldn't be enabled")
		
		newHabitViewController.newHabitNameTextField.text = "New habit name"
		textFieldTextDidChange()
		XCTAssert(newHabitViewController.startNewHabitButton.enabled, "Start New Habit button shouldn't be disabled")
		
		newHabitViewController.newHabitNameTextField.text = ""
		textFieldTextDidChange()
		XCTAssert(newHabitViewController.startNewHabitButton.enabled == false, "Start New Habit button shouldn't be enabled")
	}
		
	func test_linkTwitterAccountSwitch_requestsAccess() {
		let mockAPI = MockTwitterAPI()
		newHabitViewController.twitterHandler = TwitterHandler(api: mockAPI)
		
		newHabitViewController.linkTwitterAccountSwitch.on = true
		newHabitViewController.linkTwitterAccountSwitchValueChanged(newHabitViewController.linkTwitterAccountSwitch)
		
		XCTAssertTrue(mockAPI.accessChecked, "Access for Twitter account has not been requested")
	}
	
	private func textFieldTextDidChange() {
		newHabitViewController.habitNameTextFieldEditingChanged(newHabitViewController.newHabitNameTextField)
	}
}

