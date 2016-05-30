//
//  TwitterHandler.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol API {
	
	func requestAccessToAccounts() -> Bool
	func getAccounts() -> [ACAccount]?
}

class TwitterAPI: API {
	
	let accountStore = ACAccountStore()
	var accountType: ACAccountType
	
	init() {
		accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
	
	func requestAccessToAccounts() -> Bool {
		accountStore.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
			return success
		}
		return false
	}
	
	func getAccounts() -> [ACAccount]? {
		return accountStore.accountsWithAccountType(accountType) as? [ACAccount]
	}
}

class TwitterHandler: TwitterAPI {
	let api: API
	
	init(api: API) {
		self.api = api
	}
	
	func getAccess() -> Bool? {
		if api.requestAccessToAccounts() {
			requestAccounts()
		}
		return nil
	}
	
	func requestAccounts() {
		if let accounts = api.getAccounts() {
			print(accounts)
		}
	}
	
}
