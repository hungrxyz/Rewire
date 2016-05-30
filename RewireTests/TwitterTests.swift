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
	
	class MockTwitterAPI: API {
		var accessChecked = false
		var accountsChecked = false
		
		func requestAccessToAccounts() -> Bool {
			accessChecked = true
			return false
		}
		
		func getAccounts() -> [ACAccount]? {
			accountsChecked = true
			return nil
		}
	}
	
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
		twitterHandler.getAccess()
		
		XCTAssertTrue(mockTwitterAPI.accessChecked, "Access has not been checked")
	}
	
	func test_TwitterAccountAvailable() {
		twitterHandler.requestAccounts()
		
		XCTAssertTrue(mockTwitterAPI.accountsChecked, "Accounts were not checked")
	}
	
}
