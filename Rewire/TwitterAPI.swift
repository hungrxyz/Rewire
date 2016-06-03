//
//  TwitterAPI.swift
//  Rewire
//
//  Created by Zel Marko on 5/31/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import Accounts

/// Protocol for TwitterAPI
protocol API {
	
	var twitterHandler: TwitterHandler! { set get }
	
	func requestAccessToAccounts()
	func getAccounts()
	func presentAlertSheetWithAccounts(accounts: [ACAccount])
}

class TwitterAPI: API {
	
	var twitterHandler: TwitterHandler!
	
	var accountStore: ACAccountStore
	var accountType: ACAccountType
	
	init() {
		accountStore = ACAccountStore()
		accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
	
	func requestAccessToAccounts() {
		accountStore.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
			if success {
				self.getAccounts()
			} else {
				HUD.sharedInstance.showText("Access Denied!", description: "Go to Settings -> Twitter\nto grant access to Twitter accounts")
				self.twitterHandler.completion(accountId: nil)
			}
		}
	}
	
	func getAccounts() {
		if let accounts = accountStore.accountsWithAccountType(accountType) as? [ACAccount] {
			if accounts.count > 1 {
				presentAlertSheetWithAccounts(accounts)
			} else if accounts.isEmpty {
				HUD.sharedInstance.showText("No Accounts Available!", description: "Go to Settings -> Twitter,\nto add a Twitter account.")
				twitterHandler.completion(accountId: nil)
			} else {
				twitterHandler.completion(accountId: accounts.first!.identifier)
			}
		}
	}
	
	func presentAlertSheetWithAccounts(accounts: [ACAccount]) {
		let alertSheet = UIAlertController(title: "Select Twitter Account", message: nil, preferredStyle: .ActionSheet)
		
		for account in accounts {
			let action = UIAlertAction(title: account.username, style: .Default) { action in
				self.twitterHandler.completion(accountId: account.identifier)
			}
			alertSheet.addAction(action)
		}
		
		alertSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel) { action in
			self.twitterHandler.completion(accountId: nil)
			})
		
		let newHabitViewController = UIApplication.sharedApplication().keyWindow?.rootViewController as! NewHabitViewController
		dispatch_async(dispatch_get_main_queue()) {
			newHabitViewController.presentViewController(alertSheet, animated: true, completion: nil)
		}
	}
}

