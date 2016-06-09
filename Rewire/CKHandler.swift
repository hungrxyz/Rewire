//
//  CKHandler.swift
//  Rewire
//
//  Created by Zel Marko on 6/8/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import CloudKit

protocol CKHandlerProtocol {
	func day(day: Day)
}

class CKHandler {
	
	static let sharedInstance = CKHandler()
	
	var delegate: CKHandlerProtocol?
	let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
	var habit: Habit! {
		didSet {
			fetchToday()
		}
	}
	
	func checkValidUser(success: Bool -> ()) {
		CKContainer.defaultContainer().fetchUserRecordIDWithCompletionHandler { recordID, error in
			if let _ = recordID {
				success(true)
			} else {
				success(false)
			}
		}
	}
	
	func newHabit(habit: Habit) {
		let recordID = CKRecordID(recordName: habit.id)
		let record = CKRecord(recordType: "Habit", recordID: recordID)
		
		record["name"] = habit.name
		record["stage"] = habit.stage
		record["createdDate"] = habit.createdDate
		record["twitterAccountId"] = habit.twitterAccountId
		record["useTo_dayData"] = habit.useTo_dayData
		record["useWorkHData"] = habit.useWorkHData
		record["notifications"] = habit.notifications
//		record["tasks"] = habit.tasks
		
		saveRecord(record) { completion in
			let firstDay = Day(habit: habit,
			                   to_dayDataGoal: 10,
			                   to_dayData: 0,
			                   workHDataGoal: 10,
			                   workHData: 0,
			                   tasks: nil)
			
			self.newDay(firstDay, habitRecordID: record.recordID)
			
			NSUserDefaults.standardUserDefaults().setValue(record.recordID.recordName, forKey: "currentHabitRecordID")
		}
	}
	
	func newDay(day: Day, habitRecordID: CKRecordID) {
		let recordID = CKRecordID(recordName: day.id)
		let record = CKRecord(recordType: "Day", recordID: recordID)
		
		record["habit"] = CKReference(recordID: habitRecordID, action: .DeleteSelf)
		record["number"] = day.number
		record["date"] = day.date
		record["to_dayDataGoal"] = day.to_dayDataGoal
		record["to_dayData"] = day.to_dayData
		record["workHDataGoal"] = day.workHDataGoal
		record["workHData"] = day.workHData
//		record["tasks"] = day.tasks
		
		saveRecord(record) { completion in
			dispatch_async(dispatch_get_main_queue()) {
				if let delegate = self.delegate {
					delegate.day(day)
				}
			}
		}
	}
	
	func saveRecord(record: CKRecord, completion: Bool -> ()) {
		privateDatabase.saveRecord(record) { record, error in
			if let _ = record {
				completion(true)
			} else if let error = error {
				completion(false)
				print(error)
				
				HUD.sharedInstance.hide()
				HUD.sharedInstance.showText(error.code.description, description: error.localizedDescription)
			}
		}
	}
	
	func fetchHabitRecord(habitRecordID: String) {
		let recordID = CKRecordID(recordName: habitRecordID)
		
		privateDatabase.fetchRecordWithID(recordID) { record, error in
			if let record = record {
				self.habit = Habit(id: record.recordID.recordName,
				                   name: record["name"] as! String,
				                   stage: record["stage"] as! Int,
				                   createdDate: record["createdDate"] as! NSDate,
				                   twitterAccountId: record["twitterAccountId"] as? String,
				                   useTo_dayData: record["useTo_dayData"] as! Bool,
				                   useWorkHData: record["useWorkHData"] as! Bool,
				                   notifications: record["notifications"] as! Bool,
				                   tasks: nil)
			}
		}
	}
	
	func fetchThisWeek() {
		
	}
	
	func fetchToday() {
		let query = CKQuery(recordType: "Day", predicate: NSPredicate(format: "number == %i", dayNumberFromDate(habit.createdDate)))
		
		privateDatabase.performQuery(query, inZoneWithID: nil) { records, error in
			if let records = records {
				if let record = records.first {
					let day = Day(id: record.recordID.recordName,
					              habit: self.habit,
					              number: record["number"] as! Int,
					              date: record["date"] as! NSDate,
					              to_dayDataGoal: record["to_dayDataGoal"] as! Int,
					              to_dayData: record["to_dayData"] as! Int,
					              workHDataGoal: record["workHDataGoal"] as! Double,
					              workHData: record["workHData"] as! Double,
					              tasks: nil)
					
					dispatch_async(dispatch_get_main_queue()) {
						if let delegate = self.delegate {
							delegate.day(day)
						}
					}
				} else {
					let newDay = Day(habit: self.habit,
					                 number: dayNumberFromDate(self.habit.createdDate),
					                 to_dayDataGoal: 10,
					                 to_dayData: 0,
					                 workHDataGoal: 10,
					                 workHData: 0,
					                 tasks: nil)
					
					self.newDay(newDay, habitRecordID: CKRecordID(recordName: self.habit.id))
				}
				
			} else if let error = error {
				print(error)
			}
		}
	}
}
