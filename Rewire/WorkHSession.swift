//
//  Session.swift
//  Rewire
//
//  Created by Zel Marko on 6/9/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

struct WorkHSession {
	
	let startDate: NSDate
	let endDate: NSDate
	
	init(startDate: NSDate, endDate: NSDate) {
		self.startDate = startDate
		self.endDate = endDate
	}
}