//
//  NewRewiringViewController.swift
//  Rewire
//
//  Created by Zel Marko on 6/20/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit
import B68UIFloatLabelTextField

class NewRewiringViewController: UIViewController {
	
	@IBOutlet weak var rewiringNameTextField: B68UIFloatLabelTextField!
	@IBOutlet weak var useTo_dayDataSwitch: UISwitch!
	@IBOutlet weak var useWorkHDataSwitch: UISwitch!
	@IBOutlet weak var postProgressToTwitterSwitch: UISwitch!
	@IBOutlet weak var notificationsSwitch: UISwitch!
	@IBOutlet weak var startButton: UIButton!
	
	var twitterAccountID: TwitterAccountID?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBAction func useTo_dayDataSwitchValueChanged(sender: AnyObject) {
	}
	
	@IBAction func useWorkHDataSwitchValueChanged(sender: AnyObject) {
	}
	
	@IBAction func postProgressToTwitterSwitchValueChanged(sender: UISwitch) {
		if sender.on {
			getTwitterAccountID(withTwitterAccountConstructor: TwitterAccountIDConstructor())
		} else {
			twitterAccountID = nil
		}
	}
	
	@IBAction func notificationsSwitchValueChanged(sender: AnyObject) {
	}
	
	@IBAction func startButtonTapped(sender: AnyObject) {
	}
	
	func getTwitterAccountID<T: TwitterAccountIDConstructable>(withTwitterAccountConstructor constructor: T) {
		constructor.get { id in
			self.twitterAccountID = id
		}
	}
}
