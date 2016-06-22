//
//  TwitterError.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

enum TwitterError: ErrorType {
	case noAccess
	case noAccounts
	case cancelled
	
	var name: String? {
		switch self {
		case .noAccess: return "No Access!"
		case .noAccounts: return "No Accounts!"
		case .cancelled: return nil
		}
	}
}
