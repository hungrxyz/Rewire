//
//  RewireTests.swift
//  RewireTests
//
//  Created by Zel Marko on 5/26/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import XCTest
@testable import Rewire

class RewireTests: XCTestCase {
	
	var vc: ViewController!
	
	override func setUp() {
		super.setUp()
		
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		vc = storyboard.instantiateInitialViewController() as! ViewController
	}
	
	func testTest() {
		let _ = vc.view
		
		vc.percentage(NSDate())
		
		XCTAssert(vc.percentageLabel.text == "1", "Percetage label is not 0")
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
}
