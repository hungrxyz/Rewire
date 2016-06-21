//
//  Result.swift
//  Rewire
//
//  Created by Zel Marko on 6/21/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

enum Result<T> {
	case success(T)
	case failure(ErrorType)
}
