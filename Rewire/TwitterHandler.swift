//
//  TwitterHandler.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import Accounts

class TwitterHandler {
	var api: API
	var completion: ((accountId: String?) -> Void)!
	
	init(api: API = TwitterAPI()) {
		self.api = api
	}
	
	func setup(completion: (accountId: String?) -> Void) {
		api.twitterHandler = self
		self.completion = completion
		
		api.requestAccessToAccounts()
	}
}
