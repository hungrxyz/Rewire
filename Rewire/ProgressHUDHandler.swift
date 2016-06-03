//
//  ProgressHUDHandler.swift
//  Rewire
//
//  Created by Zel Marko on 6/2/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation
import MBProgressHUD

class HUD {
	
	static let sharedInstance = HUD()
	
	var hud: MBProgressHUD?
	var keyWindow: UIWindow!
	
	init() {
		keyWindow = UIApplication.sharedApplication().keyWindow
	}
	
	func showWithText(text: String) {
		dispatch_async(dispatch_get_main_queue()) {
			self.hud = MBProgressHUD.showHUDAddedTo(self.keyWindow, animated: true)
			self.hud!.labelText = text
		}
	}
	
	func hide() {
		if let hud = hud {
			dispatch_async(dispatch_get_main_queue()) {
				hud.hide(true)
				self.hud = nil
			}
		}
	}
	
	func showText(text: String, description: String?) {
		dispatch_async(dispatch_get_main_queue()) {
			self.hud = MBProgressHUD.showHUDAddedTo(self.keyWindow, animated: true)
			self.hud!.mode = .Text
			self.hud!.labelText = text
			if let description = description {
				self.hud!.detailsLabelText = description
			}
			
			self.hud!.hide(true, afterDelay: 2)
			self.hud = nil
		}
	}
}
