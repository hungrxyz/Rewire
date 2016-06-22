//
//  TwitterAccountConstructorTests.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
import Accounts
@testable import Rewire

class TwitterAccountConstructorTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func test_Get_GivesNil() {
		class Fake_TwitterAccountIDConstructor: TwitterAccountIDConstructable, TwitterAccountRequestable {
			var requestAccount_WasCalled = false
			
			private func requestAccount(completion: Result<String>? -> ()) {
				requestAccount_WasCalled = true
				completion(nil)
			}
		}
		
		let fakeTAIC = Fake_TwitterAccountIDConstructor()
		
		var twitterAccountID: TwitterAccountID?
		fakeTAIC.get { id in
			twitterAccountID = id
		}
		
		XCTAssertTrue(fakeTAIC.requestAccount_WasCalled, "requestAccount should have been called.")
		XCTAssertNil(twitterAccountID, "twitterAccountID should have been nil.")
	}
	
	func test_Get_GivesTwitterAccountID() {
		class Fake_TwitterAccountIDConstructor: TwitterAccountIDConstructable, TwitterAccountRequestable {
			var requestAccount_WasCalled = false
			let fakeID = "fakeID"
			
			private func requestAccount(completion: Result<String>? -> ()) {
				requestAccount_WasCalled = true
				completion(Result.success(fakeID))
			}
		}
		
		let fakeTAIC = Fake_TwitterAccountIDConstructor()
		
		var twitterAccountID: TwitterAccountID?
		fakeTAIC.get { id in
			twitterAccountID = id
		}
		
		XCTAssertTrue(fakeTAIC.requestAccount_WasCalled, "requestAccount should have been called.")
		XCTAssertEqual(twitterAccountID?.id, fakeTAIC.fakeID, "twitterAccountID's id and fakeID should have been equal.")
	}
}
