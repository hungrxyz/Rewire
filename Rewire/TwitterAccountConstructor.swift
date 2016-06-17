//
//  TwitterAccountsAccess.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

/// Access point for receiving a Twitter account ID
class TwitterAccountConstructor: TwitterAccountRequestable, TwitterAccountConstructable {
	func getTwitterAccountID(twitterAccountID: TwitterAccountID? -> ()) {
		requestAccount { account in
			if let account = account {
				twitterAccountID(TwitterAccountID(id: account.identifier))
			}
		}
	}
}