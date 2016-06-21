//
//  NewRewiringViewControllerTests.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
@testable import Rewire

class NewRewiringViewControllerTests: XCTestCase {
	
	var viewController: NewRewiringViewController!
	
	override func setUp() {
		super.setUp()
		
		viewController = UIStoryboard(name: "NewRewiring", bundle: nil).instantiateInitialViewController() as! NewRewiringViewController
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	func testGetTwitterAccountID() {
		class Fake_TwitterAccountIDConstructor: TwitterAccountIDConstructable {
			var getTwitterAccountIDWasCalled = false
			let fakeTwitterAccountID = TwitterAccountID(id: "fakeID")
			
			private func get(twitterAccountID: TwitterAccountID? -> ()) {
				getTwitterAccountIDWasCalled = true
				twitterAccountID(fakeTwitterAccountID)
			}
		}
		
		let fakeTwitterAccountIDConstructor = Fake_TwitterAccountIDConstructor()
		viewController.getTwitterAccountID(withTwitterAccountConstructor: fakeTwitterAccountIDConstructor)
		
		XCTAssert(fakeTwitterAccountIDConstructor.getTwitterAccountIDWasCalled, "getTwitterAccountID function should have been called")
		XCTAssertEqual(viewController.twitterAccountID, fakeTwitterAccountIDConstructor.fakeTwitterAccountID, "twitterAcocuntID should be the same as the fakeTwitterAccountID")
	}
}

