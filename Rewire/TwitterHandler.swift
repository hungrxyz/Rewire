//
//  TwitterHandler.swift
//  Rewire
//
//  Created by Zel Marko on 5/30/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import Accounts

protocol API {
	func requestTwitterAccountAccess()
}

class TwitterAPI: API {
	func requestTwitterAccountAccess() {
		
	}
}

class TwitterHandler: TwitterAPI {
	let api: API
	
	init(api: API) {
		self.api = api
	}
	
	func whatever() {
		api.requestTwitterAccountAccess()
	}
	
}
