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
	
}

class CKHandler: CKHandlerProtocol {
	
	static let sharedInstance = CKHandler()
	
	let privateDatabase = CKContainer.defaultContainer().privateCloudDatabase
	
	func checkValidUser(success: Bool -> ()) {
		CKContainer.defaultContainer().fetchUserRecordIDWithCompletionHandler { recordID, error in
			if let _ = recordID {
				success(true)
			} else {
				success(false)
			}
		}
	}
	
	func newHabit(habit: Habit, success: Bool -> ()) {
		let record = CKRecord(recordType: "Habit")
		record["name"] = habit.name
		record["stage"] = habit.stage
		record["createdDate"] = habit.createdDate
		record["twitterAccountId"] = habit.twitterAccountId
		record["useTo_dayData"] = habit.useTo_dayData
		record["useWorkHData"] = habit.useWorkHData
		record["notifications"] = habit.notifications
//		record["tasks"] = habit.tasks
		
//		saveRecord(record) { completion in
//			dispatch_async(dispatch_get_main_queue()) {
//				success(completion)
//			}
//		}
	}
	
	func saveRecord(record: CKRecord, completion: Bool -> ()) {
		privateDatabase.saveRecord(record) { record, error in
			if let _ = record {
				completion(true)
				HUD.sharedInstance.hide()
			} else if let error = error {
				completion(false)
				print(error)
				HUD.sharedInstance.showText(error.code.description, description: error.localizedDescription)
			}
		}
	}
}
