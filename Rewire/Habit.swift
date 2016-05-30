//
//  Habit.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import RealmSwift

class Habit: Object {
	dynamic var id = NSUUID().UUIDString
	dynamic var name = ""
	dynamic var linkTwitterAccount = false
	dynamic var notifications = false
	dynamic var useTo_dayData = false
	dynamic var useWorkHData = false
	
	override static func primaryKey() -> String? {
		return "id"
	}
}
