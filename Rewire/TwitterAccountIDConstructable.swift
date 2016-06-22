//
//  TwitterAccountIDConstructable.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TwitterAccountIDConstructable: TwitterAccountRequestable, Presentable {
	func get(twitterAccountID: TwitterAccountID? -> ())
}

extension TwitterAccountIDConstructable {
	func get(twitterAccountID: TwitterAccountID? -> ()) {
		requestAccount { result in
			if let result = result {
				switch result {
				case .success(let identifier):
					twitterAccountID(TwitterAccountID(id: identifier))
				case .failure(let error as TwitterError):
					switch error {
					case .noAccess, .noAccounts:
						self.show(HUDType.error(error.name!))
					case .cancelled: break
					}
				default: break
				}
			}
		}
	}
}
