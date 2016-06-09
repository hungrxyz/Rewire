//
//  DateHelper.swift
//  Rewire
//
//  Created by Zel Marko on 6/9/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

let calendar = NSCalendar.currentCalendar()

func today5AM() -> Double {
	let today = calendar.dateByAddingUnit(.Hour, value: -5, toDate: NSDate(), options: [])
	let todayStartOfDay = calendar.startOfDayForDate(today!)
	let today5AM = calendar.dateByAddingUnit(.Hour, value: 5, toDate: todayStartOfDay, options: [])
	
	return today5AM!.timeIntervalSinceReferenceDate
}

/// Calcualtes and returns the right day number for today
func dayNumberFromDate(date: NSDate) -> Int {
	let createdDateComponents = calendar.components([.Year, .Month, .Day, .Hour], fromDate: date)
	
	createdDateComponents.day = createdDateComponents.hour < 5 ? createdDateComponents.day - 1 : createdDateComponents.day
	createdDateComponents.hour = 5
	
	let modifiedCreatedDate = calendar.dateFromComponents(createdDateComponents)!
	
	let differenceToNowComponents = calendar.components([.Day], fromDate: modifiedCreatedDate, toDate: NSDate(), options: [])
	
	return differenceToNowComponents.day + 1
}
