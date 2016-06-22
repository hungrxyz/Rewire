//
//  TwitterAccountRequest.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol TwitterAccountRequestable: TwitterAccountAccessRequestable, TwitterAccountsSheetRenderer {
	func requestAccount(completion: Result<String>? -> ())
}

extension TwitterAccountRequestable {
	func requestAccount(completion: Result<String>? -> ()) {
		requestAccess { granted in
			if granted {
				let accountStore = TwitterAccountIDConstructor.sharedInstance.accountStore
				let accountType = TwitterAccountIDConstructor.sharedInstance.accountType
				
				if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
					switch accounts.count {
					case 0:
						completion(Result.failure(TwitterError.noAccounts))
					case 1:
						completion(Result.success(accounts.first!.identifier))
					case 2...Int(UInt8.max):
						self.presentAlertSheet(withAccounts: accounts) { result in
							switch result {
							case .success(let account):
								completion(.success(account.identifier))
							case .failure(let error):
								// MARK: Need alert to present the error
								print(error)
								completion(nil)
							}
						}
					default:
						completion(nil)
					}
				}
			} else {
				completion(Result.failure(TwitterError.deniedPermission))
				print("No Access")
			}
		}
	}
}
