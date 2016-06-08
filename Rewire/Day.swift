//
//  Day.swift
//  Rewire
//
//  Created by Zel Marko on 6/4/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

class Day {
	var habit: Habit
	var number: Int
	var date: NSDate
	var to_dayDataGoal: Int
	var to_dayData: Int
	var workHDataGoal: Double
	var workHData: Double
	var tasks: [Task]?
	
	init(habit: Habit,
	     number: Int = 1,
	     date: NSDate = NSDate(),
	     to_dayDataGoal: Int,
	     to_dayData: Int,
	     workHDataGoal: Double,
	     workHData: Double,
	     tasks: [Task]?) {
		
		self.habit = habit
		self.number = number
		self.date = date
		self.to_dayDataGoal = to_dayDataGoal
		self.to_dayData = to_dayData
		self.workHDataGoal = workHDataGoal
		self.workHData = workHData
		self.tasks = tasks
	}
}