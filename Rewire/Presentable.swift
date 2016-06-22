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
			HUD.flash(.LabeledSuccess(title: text, subtitle: nil))
		case .error(let errorMessage):
			HUD.flash(.LabeledError(title: errorMessage, subtitle: nil))
		case .progress(let text):
			HUD.show(.LabeledProgress(title: text, subtitle: nil))
		}
	}
}