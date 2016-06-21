//
//  Day.swift
//  Rewire
//
//  Created by Zel Marko on 6/4/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

struct Day {
	let id: String
	let rewiring: Rewiring
	let number: Int
	let date: NSDate
	let to_dayDataGoal: Int
	var to_dayData: Int
	let workHDataGoal: Double
	var workHData: Double
	var tasks: [Task]?
	
	init(id: String = NSUUID().UUIDString,
	     rewiring: Rewiring,
	     number: Int = 1,
	     date: NSDate = NSDate(),
	     to_dayDataGoal: Int,
	     to_dayData: Int,
	     workHDataGoal: Double,
	     workHData: Double,
	     tasks: [Task]?) {
		
		self.id = id
		self.rewiring = rewiring
		self.number = number
		self.date = date
		self.to_dayDataGoal = to_dayDataGoal
		self.to_dayData = to_dayData
		self.workHDataGoal = workHDataGoal
		self.workHData = workHData
		self.tasks = tasks
	}
}