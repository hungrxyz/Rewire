//
//  TwitterTests.swift
//  Rewire
//
//  Created by Zel Marko on 5/31/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
import Accounts
@testable import Rewire

class TwitterTests: XCTestCase {
	
	var mockTwitterAPI: MockTwitterAPI!
	var twitterHandler: TwitterHandler!
	
	override func setUp() {
		super.setUp()
		
		mockTwitterAPI = MockTwitterAPI()
		twitterHandler = TwitterHandler(api: mockTwitterAPI)
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func test_TwitterAccountAccessRequested() {
		twitterHandler.setup()
		
		XCTAssertTrue(mockTwitterAPI.accessChecked, "Access has not been checked")
		XCTAssertTrue(mockTwitterAPI.accountsChecked, "Accounts were not checked")
	}
	
	func test_TwitterAccount_returned() {
		let account = twitterHandler.setup()
		
		XCTAssertNotNil(account, "No account was returned")
	}
	
}

class MockTwitterAPI: API {
	var accessChecked = false
	var accountsChecked = false
	
	func requestAccessToAccounts() -> Bool {
		accessChecked = true
		return true
	}
	
	func getAccounts() -> [ACAccount]? {
		accountsChecked = true
		let mockAccount = ACAccount()
		mockAccount.username = "mockAccount"
		return [mockAccount]
	}
}
