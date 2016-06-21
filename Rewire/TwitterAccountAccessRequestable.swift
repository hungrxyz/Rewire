//
//  TwitterAccountAccessRequest.swift
//  Rewire
//
//  Created by Zel Marko on 6/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

protocol TwitterAccountAccessRequestable {
	func requestAccess(granted: Bool -> ())
}