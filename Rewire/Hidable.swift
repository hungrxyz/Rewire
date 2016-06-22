//
//  Hidable.swift
//  Rewire
//
//  Created by Zel Marko on 6/22/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import PKHUD

protocol Hidable {
	func hide()
}

extension Hidable {
	func hide() {
		HUD.hide()
	}
}
