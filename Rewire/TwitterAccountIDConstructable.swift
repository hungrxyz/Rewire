//
//  TwitterAccountIDConstructable.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TwitterAccountIDConstructable: TwitterAccountRequestable {
	func get(twitterAccountID: TwitterAccountID? -> ())
}

extension TwitterAccountIDConstructable {
	func get(twitterAccountID: TwitterAccountID? -> ()) {
		requestAccount { result in
			if let result = result {
				switch result {
				case .success(let identifier):
					twitterAccountID(TwitterAccountID(id: identifier))
				case .failure(let error):
					// MARK: Need alert to present the error
					print(error)
				}
			}
		}
	}
}
