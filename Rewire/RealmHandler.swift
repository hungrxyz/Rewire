//
//  RealmHandler.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider {
	class func realm() -> Realm  {
		if let _ = NSClassFromString("XCTest") {
			Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "RealmTests"
			
			return try! Realm()
		} else {
//			let container = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.zzzel.to-day")!
//			let realmURL = container.URLByAppendingPathComponent("db.realm")
//			var config = Realm.Configuration()
//			config.fileURL = realmURL
//			Realm.Configuration.defaultConfiguration = config
			
			return try! Realm()
		}
	}
}

class RealmHandler {
	
	static let sharedInstance = RealmHandler()
	
	let realm = RealmProvider.realm()
	
	func addNewHabit(habit: Habit) {
		do {
			try realm.write {
				realm.add(habit)
			}
		} catch {
			print(error)
		}
	}
	
}
