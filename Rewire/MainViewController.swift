//
//  MainViewController.swift
//  Rewire
//
//  Created by Zel Marko on 6/8/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
	
	@IBOutlet weak var habitNameLabel: UILabel!
	@IBOutlet weak var weekLabel: UILabel!
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var to_dayTasksLabel: UILabel!
	@IBOutlet weak var workHHoursLabel: UILabel!
	@IBOutlet weak var to_dayProgressView: UIProgressView!
	@IBOutlet weak var workHProgressView: UIProgressView!
	@IBOutlet weak var tableView: UITableView!
	
	var today: Day! {
		didSet {
			tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		CKHandler.sharedInstance.delegate = self
	}
}

extension MainViewController: UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let habit = CKHandler.sharedInstance.habit {
			var count = 0
			
			if habit.useTo_dayData {
				count += 1
			}
			if habit.useWorkHData {
				count += 1
			}
			
			return count
		}
		
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("MainCell") as! MainCell
		
		if indexPath.row == 0 {
			cell.taskNameLabel.text = "To-day tasks"
			cell.taskStatLabel.text = today.to_dayData.description + " / " + today.to_dayDataGoal.description
		} else {
			cell.taskNameLabel.text = "WorkH hours"
			cell.taskStatLabel.text = today.workHData.description + " / " + today.workHDataGoal.description
		}
		
		return cell
	}
}

extension MainViewController: CKHandlerProtocol {
	
	func day(day: Day) {
		today = day
		
		habitNameLabel.text = day.habit.name
		dayLabel.text = "Day " + day.number.description
		
		HUD.sharedInstance.hide()
	}
}
