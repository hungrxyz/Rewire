//
//  TwitterAccountsSheetRenderer.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import Accounts

protocol TwitterAccountsSheetRenderer { }

extension TwitterAccountsSheetRenderer {
	/// Presents Alert Sheet with all Twitter accounts that are available
	func presentAlertSheetWithAccounts(accounts: [ACAccount], selectedAccount: ACAccount? -> ()) {
		let alertSheet = UIAlertController(title: "Select Twitter Account", message: nil, preferredStyle: .ActionSheet)
		
		for account in accounts {
			let action = UIAlertAction(title: account.username, style: .Default) { action in
				selectedAccount(account)
			}
			alertSheet.addAction(action)
		}
		
		alertSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
			selectedAccount(nil)
		})
		
		if let newHabitViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as? NewHabitViewController {
			dispatch_async(dispatch_get_main_queue()) {
				newHabitViewController.presentViewController(alertSheet, animated: true, completion: nil)
			}
		}

	}
}