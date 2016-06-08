//
//  CKTo-dayDataHandler.swift
//  Rewire
//
//  Created by Zel Marko on 6/8/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import CloudKit

protocol CKTo_dayDataHandlerProtocol {
	func checkExistingTo_dayData()
}

class CKTo_dayDataHandler: CKTo_dayDataHandlerProtocol {
	
	static let sharedInstance = CKTo_dayDataHandler()
	
	/// Private database for To-day data, of the signed in user
	let privateDatabase = CKContainer(identifier: "iCloud.com.zzzel.-procrastinate").privateCloudDatabase
	
	/// Checks for existing tasks from To-day
	func checkExistingTo_dayData() {
		let query = CKQuery(recordType: "Tasks", predicate: NSPredicate(value: true))
		
		let queryOperation = CKQueryOperation(query: query)
		queryOperation.resultsLimit = 1
		queryOperation.queryCompletionBlock = { cursor, error in
			HUD.sharedInstance.hide()
			if let _ = cursor {
				HUD.sharedInstance.showText("Success", description: nil)
			} else {
				HUD.sharedInstance.showText("No To-day data", description: "Check out the To-day app")
			}
		}
		
		privateDatabase.addOperation(queryOperation)
	}
}
