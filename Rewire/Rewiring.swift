//
//  Habit.swift
//  Rewire
//
//  Created by Zel Marko on 6/4/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

struct Rewiring {
	let id: String
	var name: String
	var stage: Int
	let startDate: NSDate
	var twitterAccountId: String?
	var useTo_dayData: Bool
	var useWorkHData: Bool
	var notifications: Bool
	var tasks: [Task]?
	
	init(id: String = NSUUID().UUIDString,
	     name: String,
	     stage: Int = 1,
	     startDate: NSDate = NSDate(),
	     twitterAccountId: String?,
	     useTo_dayData: Bool,
	     useWorkHData: Bool,
	     notifications: Bool,
	     tasks: [Task]?) {
		
		self.id = id
		self.name = name
		self.stage = stage
		self.startDate = startDate
		self.twitterAccountId = twitterAccountId
		self.useTo_dayData = useTo_dayData
		self.useWorkHData = useWorkHData
		self.notifications = notifications
		self.tasks = tasks
	}
}
