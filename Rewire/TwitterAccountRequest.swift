//
//  TwitterAccountRequest.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol TwitterAccountRequest: TwitterAccountAccessRequest, TwitterAccountsSheetRenderer { }

extension TwitterAccountRequest {
	func requestAccount(account: ACAccount? -> ()) {
		requestAccess { granted in
			if granted {
				if let accounts = self.accountStore.accountsWithAccountType(self.accountType) as? [ACAccount] {
					switch accounts.count {
					case 0:
						account(nil)
					case 1:
						account(accounts.first)
					default:
						self.presentAlertSheetWithAccounts(accounts) { selectedAccount in
							account(selectedAccount)
						}
					}
				}
			} else {
				account(nil)
				print("No Access")
			}
		}
	}
}
