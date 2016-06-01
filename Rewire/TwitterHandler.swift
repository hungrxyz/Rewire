//
//  TwitterHandler.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

class TwitterHandler {
	let api: API
	
	init(api: API = TwitterAPI()) {
		self.api = api
	}
	
	func setup() -> String? {
		if api.requestAccessToAccounts() {
			if let accounts = api.getAccounts() {
				return processAccounts(accounts)
			}
		}
		return nil
	}
	
	func processAccounts(accounts: [ACAccount]) -> String {
		return accounts.first!.username
	}
}
