//: Playground - noun: a place where people can play

import UIKit
import Accounts

protocol TwitterAccess {
	var accountStore: ACAccountStore { get }
	var accountType: ACAccountType { get }
}

extension TwitterAccess {
	var accountStore: ACAccountStore {
		return ACAccountStore()
	}
	var accountType: ACAccountType {
		return ACAccountStore().accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
	}
}

protocol TwitterAccessRequest: TwitterAccess {
	func requestAccess(granted: Bool -> ())
}

extension TwitterAccessRequest {
	func requestAccess(granted: Bool -> ()) {
		accountStore.requestAccessToAccountsWithType(accountType, options: nil) { success, error in
			print(error)
			granted(success)
		}
	}
}

protocol TwitterAccountRequest: TwitterAccessRequest {
	func requestAccount(account: ACAccount -> ())
}

extension TwitterAccessRequest {
	func requestAccount(account: ACAccount -> ()) {
		requestAccess { granted in
			if granted {
				if let accounts = self.accountStore.accountsWithAccountType(self.accountType), firstAccount = accounts[0] as? ACAccount {
					account(firstAccount)
				}
			} else {
				print("No access")
			}
		}
	}
}

protocol TwitterConstructable: TwitterAccountRequest {
	func getTwitterAccountID(accountIdentifier: String -> ())
}

extension TwitterConstructable {
	func getTwitterAccountID(accountIdentifier: String -> ()) {
		requestAccount { account in
			accountIdentifier(account.identifier)
		}
	}
}

struct TwitterAccountID: TwitterConstructable {
	var id: String = ""
	
	init() {
		getTwitterAccountID { id in
			self.id = id
		}
	}
}

TwitterAccountID()




