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
struct TwitterAccountIDConstructor: TwitterAccountIDConstructable, TwitterAccountAccessRequestable,TwitterAccountRequestable, TwitterAccountsSheetRenderer {

	let accountStore: ACAccountStore
	let accountType: ACAccountType
	
	init() {
		accountStore = ACAccountStore()
		accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
	
	func get(twitterAccountID: TwitterAccountID? -> ()) {
		requestAccount { result in
			if let result = result {
				switch result {
				case .success(let account):
					twitterAccountID(TwitterAccountID(id: account.identifier))
				case .failure(let error):
					// MARK: Need alert to present the error
					print(error)
				}
			}
		}
	}
	
	internal func requestAccess(granted: Bool -> ()) {
		accountStore.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
			if error != nil {
				print(error)
			}
			granted(success)
		}
	}
	
	internal func requestAccount(completion: Result<ACAccount>? -> ()) {
		requestAccess { granted in
			if granted {
				if let accounts = self.accountStore.accountsWithAccountType(self.accountType) as? [ACAccount] {
					switch accounts.count {
					case 0:
						completion(Result.failure(TwitterError.noAccounts))
					case 1:
						completion(Result.success(accounts.first!))
					default:
						self.presentAlertSheet(withAccounts: accounts) { result in
							switch result {
							case .success(let account):
								completion(.success(account))
							case .failure(let error):
								// MARK: Need alert to present the error
								print(error)
								completion(nil)
							}
						}
					}
				}
			} else {
				completion(Result.failure(TwitterError.deniedPermission))
				print("No Access")
			}
		}
	}
	
	internal func presentAlertSheet(withAccounts accounts: [ACAccount], completion: Result<ACAccount> -> ()) {
		let alertSheet = UIAlertController(title: "Select Twitter Account", message: nil, preferredStyle: .ActionSheet)
		
		for account in accounts {
			let action = UIAlertAction(title: account.username, style: .Default) { action in
				completion(Result.success(account))
			}
			alertSheet.addAction(action)
		}
		
		alertSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
			completion(Result.failure(TwitterError.cancelled))
			})
		
		if let currentViewController = UIApplication.sharedApplication().keyWindow?.rootViewController {
			dispatch_async(dispatch_get_main_queue()) {
				currentViewController.presentViewController(alertSheet, animated: true, completion: nil)
			}
		}
	}
}