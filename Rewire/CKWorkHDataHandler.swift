//
//  CKWorkHDataHandler.swift
//  Rewire
//
//  Created by Zel Marko on 6/8/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import CloudKit

protocol CKWorkHDataHandlerProtocol {
	func checkExistingWorkHData()
}

class CKWorkHDataHandler: CKWorkHDataHandlerProtocol {
	
	static let sharedInstance = CKWorkHDataHandler()
	
	/// Private database for WorkH data, of the signed in user
	let privateDatabase = CKContainer(identifier: "iCloud.com.zzzel.WorkH").privateCloudDatabase
	
	/// Checks for existing WorkH data
	func checkExistingWorkHData() {
		let query = CKQuery(recordType: "Session", predicate: NSPredicate(value: true))
		
		let queryOperation = CKQueryOperation(query: query)
		queryOperation.resultsLimit = 1
		queryOperation.queryCompletionBlock = { cursor, error in
			HUD.sharedInstance.hide()
			if let _ = cursor {
				HUD.sharedInstance.showText("Success", description: nil)
			} else {
				print(error)
				HUD.sharedInstance.showText("No WorkH data", description: "Check out the WorkH app")
			}
		}
		
		privateDatabase.addOperation(queryOperation)
	}
}
