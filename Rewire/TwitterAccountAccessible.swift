//
//  TwitterAccountAccessible.swift
//  Rewire
//
//  Created by Zel Marko on 6/17/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol TwitterAccountAccessible {
	var accountStore: ACAccountStore { get }
	var accountType: ACAccountType { get }
}

extension TwitterAccountAccessible {
	var accountStore: ACAccountStore {
		return ACAccountStore()
	}
	var accountType: ACAccountType {
		return ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
}
