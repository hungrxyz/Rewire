//
//  TwitterAPI.swift
//  Rewire
//
//  Created by Zel Marko on 5/31/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

/// Protocol for TwitterAPI
protocol API {
	
	func requestAccessToAccounts() -> Bool
	func getAccounts() -> [ACAccount]?
}

class TwitterAPI: API {
	
	var accountStore: ACAccountStore
	var accountType: ACAccountType
	
	init() {
		accountStore = ACAccountStore()
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

