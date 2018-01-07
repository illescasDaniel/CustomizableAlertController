//
//  ViewController.swift
//  CustomizableAlertController
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func displayAlert(_ sender: UIButton) {
		
		let darkAlertController = DarkAlertController(title: "Do you want to do X?", message: ":D hii", preferredStyle: .alert)
		darkAlertController.addAction(title: "Yes", style: .default)
		darkAlertController.addAction(title: "Cancel", style: .cancel)
		
		let greenAction = UIAlertAction(title: "I'm green!", style: .default)
		darkAlertController.addAction(greenAction)
		
		darkAlertController.addParallexEffect(x: 20, y: 20)
		
		self.present(darkAlertController, animated: true)
		
		// darkAlertController.lazyContentView?.backgroundColor = .red

		darkAlertController.titleAttributes += [
			StringAttribute(key: .font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: "Do ".count, length: "you".count)),
			StringAttribute(key: .font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: "Do you want to do ".count, length: "X".count))
		]
		
		darkAlertController.messageAttributes += [
			StringAttribute(key: .foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: 3))
		]
		
		greenAction.titleAttributes = [
			StringAttribute(key: .foregroundColor, value: UIColor.green)
		]
	}
}

