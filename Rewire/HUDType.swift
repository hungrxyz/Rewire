//
//  HUDType.swift
//  Rewire
//
//  Created by Zel Marko on 6/22/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

enum HUDType: Equatable {
	case success(String?)
	case error(String)
	case progress(String?)
}

func ==(lhs: HUDType, rhs: HUDType) -> Bool {
	switch (lhs, rhs) {
	case (let .success(text1), let .success(text2)): return text1 == text2
	case (let .error(text1), let .error(text2)): return text1 == text2
	case (let .progress(text1), let .progress(text2)): return text1 == text2
	default: return false
	}
}
