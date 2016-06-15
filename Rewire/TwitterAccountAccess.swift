//
//  TwitterAccountsAccess.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

/// Holds the account store and account type for Twitter
protocol TwitterAccountAccess {
	var accountStore: ACAccountStore { get }
	var accountType: ACAccountType { get }
}

extension TwitterAccountAccess {
	var accountStore: ACAccountStore {
		return ACAccountStore()
	}
	var accountType: ACAccountType {
		return ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
}
