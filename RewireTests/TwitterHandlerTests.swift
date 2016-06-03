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

class TwitterHandlerTests: XCTestCase {
	
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
	
	func test_twitterSetupProcess_singleAccount() {
		let testAccount = ACAccount()
		testAccount.username = "testAccount"
		
		mockTwitterAPI.accounts = [testAccount]
		
		let expectation = expectationWithDescription("Get single account")
		
		twitterHandler.setup { accountUserName in
			XCTAssertNotNil(accountUserName, "Returned string is nil")
			
			expectation.fulfill()
		}
		
		waitForExpectationsWithTimeout(1) { (error) in
			if let error = error {
				print(error)
			}
		}
		
		XCTAssertTrue(mockTwitterAPI.accessChecked, "Access for the accounts was not checked")
		XCTAssertTrue(mockTwitterAPI.accountsChecked, "Accounts were not tried to be retrieved")
	}
	
	func test_twitterSetupProcess_multipleAccounts() {
		let testAccount1 = ACAccount()
		testAccount1.username = "testAccount1"
		let testAccount2 = ACAccount()
		testAccount2.username = "testAccount2"
		
		mockTwitterAPI.accounts = [testAccount1, testAccount2]
		
		let expectation = expectationWithDescription("Get account username")
		
		twitterHandler.setup { accountUserName in
			XCTAssertEqual(accountUserName, testAccount2.username, "Returned accounts username is not \(testAccount2.username)")
			
			expectation.fulfill()
		}
		
		waitForExpectationsWithTimeout(1) { (error) in
			if let error = error {
				print(error)
			}
		}
		
		XCTAssertTrue(mockTwitterAPI.multipleAccountsSheetPresented, "Alert Sheet for multiple accounts was not called")
	}
	
	func test_twitterSetupProcess_returnNilIfAccessDenied() {
		let expectation = expectationWithDescription("Expect nil for returned account username")
		
		twitterHandler.setup { accountUserName in
			XCTAssertNil(accountUserName, "returned account user name should be nil")
			
			expectation.fulfill()
		}
		
		waitForExpectationsWithTimeout(1, handler: nil)
	}
}

class MockTwitterAPI: API {
	// Test Flags
	var accessChecked = false
	var accountsChecked = false
	var multipleAccountsSheetPresented = false
	
	// Required
	var twitterHandler: TwitterHandler!
	
	// Testing Parameters
	var accounts = [ACAccount]()
	
	func requestAccessToAccounts() {
		getAccounts()
		accessChecked = true
	}
	
	func getAccounts() {
		accountsChecked = true
		if accounts.count > 1 {
			presentAlertSheetWithAccounts(accounts)
		} else {
			if !accounts.isEmpty {
				twitterHandler.completion(accountId: accounts.first!.username)
			} else {
				twitterHandler.completion(accountId: nil)
			}
		}
	}
	
	func presentAlertSheetWithAccounts(accounts: [ACAccount]) {
		twitterHandler.completion(accountId: accounts.last!.username)
		
		multipleAccountsSheetPresented = true
	}
}
