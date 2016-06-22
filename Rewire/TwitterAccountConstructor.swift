//
//  TwitterAccountsAccess.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import Accounts

/// Access point for receiving a Twitter account ID
struct TwitterAccountIDConstructor: TwitterAccountIDConstructable {
	
	static let sharedInstance = TwitterAccountIDConstructor()

	let accountStore: ACAccountStore
	let accountType: ACAccountType
	
	init() {
		accountStore = ACAccountStore()
		accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
}