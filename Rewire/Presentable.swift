//
//  Presentable.swift
//  Rewire
//
//  Created by Zel Marko on 6/22/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import PKHUD

protocol Presentable {
	func show(type: HUDType)
}

extension Presentable {
	func show(type: HUDType) {
		switch type {
		case .success(let text):
			dispatch_async(dispatch_get_main_queue()) {
				HUD.flash(.LabeledSuccess(title: text, subtitle: nil), delay: 1.0)
			}
		case .error(let errorMessage):
			dispatch_async(dispatch_get_main_queue()) {
				HUD.flash(.LabeledError(title: errorMessage, subtitle: nil), delay: 1.0)
			}
		case .progress(let text):
			dispatch_async(dispatch_get_main_queue()) {
				HUD.show(.LabeledProgress(title: text, subtitle: nil))
			}
		}
	}
}