//
//  TwitterAccountConstructable.swift
//  Rewire
//
//  Created by Zel Marko on 6/17/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TwitterAccountConstructable {
	func getTwitterAccountID(twitterAccountID: TwitterAccountID? -> ())
}
