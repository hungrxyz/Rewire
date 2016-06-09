//
//  MainCell.swift
//  Rewire
//
//  Created by Zel Marko on 6/9/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
	
	@IBOutlet weak var taskNameLabel: UILabel!
	@IBOutlet weak var taskStatLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
