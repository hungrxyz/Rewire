//
//  TwitterAccountAccessRequest.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol TwitterAccountAccessRequestable {
	func requestAccess(granted: Bool -> ())
}

extension TwitterAccountAccessRequestable {
	func requestAccess(granted: Bool -> ()) {
		let accountStore = TwitterAccountIDConstructor.sharedInstance.accountStore
		let accountType = TwitterAccountIDConstructor.sharedInstance.accountType
		
		accountStore.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
			if error != nil {
				print(error)
			}
			granted(success)
		}
	}
	
}