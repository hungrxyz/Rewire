//
//  Habit.swift
//  Rewire
//
//  Created by Zel Marko on 6/4/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class Habit {
	var name: String
	var createdDate: NSDate
	var twitterAccountId: String?
	var useTo_dayData: Bool
	var useWorkHData: Bool
	var notifications: Bool
	var customTasks: [Task]?
	
	init(name: String, createdDate: NSDate = NSDate(), twitterAccountId: String?, useTo_dayData: Bool = false, useWorkHData: Bool = false, notifications: Bool = false, customTasks: [Task]?) {
		self.name = name
		self.createdDate = createdDate
		self.twitterAccountId = twitterAccountId
		self.useTo_dayData = useTo_dayData
		self.useWorkHData = useWorkHData
		self.notifications = notifications
		self.customTasks = customTasks
	}
}
