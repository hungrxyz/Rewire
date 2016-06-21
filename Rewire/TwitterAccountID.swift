//
//  TwitterAccountID.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

struct TwitterAccountID: Equatable {
	var id: String
}

func ==(lhs: TwitterAccountID, rhs: TwitterAccountID) -> Bool {
	return lhs.id == rhs.id
}
