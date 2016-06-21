//
//  TwitterAccountsSheetRenderer.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TwitterAccountsSheetRenderer {
	associatedtype A
	
	/// Creates and presents `UIAlertViewController` with available `ACAccount`s.
	func presentAlertSheet(withAccounts accounts: [A], completion: Result<A> -> ())
}