//
//  TwitterAccountsSheetRenderer.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import Accounts

protocol TwitterAccountsSheetRenderer {
	/// Creates and presents `UIAlertViewController` with available `ACAccount`s.
	func presentAlertSheet(withAccounts accounts: [ACAccount], completion: Result<ACAccount> -> ())
}

extension TwitterAccountsSheetRenderer {
	func presentAlertSheet(withAccounts accounts: [ACAccount], completion: Result<ACAccount> -> ()) {
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