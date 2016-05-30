//
//  NewHabitTests.swift
//  Rewire
//
//  Created by Zel Marko on 5/29/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
@testable import Rewire

class NewHabitTests: XCTestCase {
	
	var newHabitViewController: NewHabitViewController!
	
	override func setUp() {
		super.setUp()
		
		newHabitViewController = UIStoryboard(name: "NewHabit", bundle: nil).instantiateInitialViewController() as! NewHabitViewController
		
		_ = newHabitViewController.view
		
		try! RealmProvider.realm().write {
			RealmProvider.realm().deleteAll()
		}
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
	
	func textFieldTextDidChange() {
		newHabitViewController.textField(newHabitViewController.newHabitNameTextField, shouldChangeCharactersInRange: NSRange(), replacementString: "")
	}	
	
	func testSwitchesAreFunctional() {
		newHabitViewController.linkTwitterAccountSwitch.on = true
		newHabitViewController.notificationsSwitch.on = true
		newHabitViewController.useTo_dayDataSwitch.on = true
		newHabitViewController.useWorkHDataSwitch.on = true
		
		newHabitViewController.startNewHabitButton.enabled = true
		newHabitViewController.startNewHabitButtonTapped(newHabitViewController)
		
		let newHabit = RealmProvider.realm().objects(Habit).first!
		XCTAssert(newHabit.linkTwitterAccount, "Link Twitter account should be true")
		XCTAssert(newHabit.notifications, "Notifications should be true")
		XCTAssert(newHabit.useTo_dayData, "Use To-day Data sohuld be true")
		XCTAssert(newHabit.useWorkHData, "Use WorkH Data should be true")
	}
	
	func testCorrectHabitNameSaved() {
		newHabitViewController.newHabitNameTextField.text = "New Habit Name"
		
		newHabitViewController.startNewHabitButton.enabled = true
		newHabitViewController.startNewHabitButtonTapped(newHabitViewController)
		
		let newHabit = RealmProvider.realm().objects(Habit).first!
		XCTAssertEqual(newHabit.name, "New Habit Name", "Name of saved habit should be \"New Habit Name\"")
	}
	
	func test_LinkTwitterAccountSwitch_ChecksForAccounts() {
		newHabitViewController.linkTwitterAccountSwitch.on = true
		newHabitViewController.linkTwitterAccountSwitchValueChanged(newHabitViewController)
		
		
	}
		
}

