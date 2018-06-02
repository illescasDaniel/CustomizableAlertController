//
//  ViewController.swift
//  CustomizableAlertController
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//

import UIKit

class MobileDataItem: UITableViewController {
	
	override func viewDidLoad() {
		self.tableView.rowHeight = 35
		self.tableView.isScrollEnabled = false
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
		
		cell.imageView?.image = #imageLiteral(resourceName: "safariIcon")
		cell.textLabel?.text = "Safari"
		cell.detailTextLabel?.text = "474MB"
		cell.accessoryView = UISwitch()
		
		return cell
	}
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
		let statusBarColor = UIColor(red: 32/255, green: 149/255, blue: 215/255, alpha: 1.0)
		statusBarView.backgroundColor = statusBarColor
		
		statusBarView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
		
		self.view.addSubview(statusBarView)
	}
	
	@IBAction func displayAlert(_ sender: UIButton) {
		
		let mobileDataAlertController = CustomizableAlertController(title: "Mobile Data is Turned Off for \"Safari\"", message: "You can turn on mobile data. Open Settings for more information", preferredStyle: .alert)
		
		let safariAction = UIAlertAction()
		safariAction.tableViewController = MobileDataItem()
		mobileDataAlertController.addAction(safariAction)
		
		mobileDataAlertController.addAction(title: "Settings", style: .default) { _ in
			
		}
		
		mobileDataAlertController.addAction(title: "OK", style: .cancel) { _ in
			
		}
		
		self.present(mobileDataAlertController, animated: true)
		/*let darkAlertController = DarkAlertController(title: "Do you want to do X?", message: ":D hii", preferredStyle: .actionSheet)
		darkAlertController.addAction(title: "Yes", style: .default, image: #imageLiteral(resourceName: "iconTest"))
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
		cancelAction.titleTextColor = .blue
		
		darkAlertController.addAction(cancelAction)
		
		let greenAction = UIAlertAction(title: "I'm green!", style: .default)
		darkAlertController.addAction(greenAction)
		
		let labelElement = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 20))
		labelElement.text = "Hii!!"
		labelElement.textColor = .white
		greenAction.accessoryView = labelElement
		
		let testAction = UIAlertAction(title: "Wow, a switch!", style: .default)
		darkAlertController.addAction(testAction)
		
		// Adding a Switch easily
		let switchElement = UISwitch()
		switchElement.addTarget(self, action: #selector(testFunc), for: .valueChanged)
		testAction.accessoryView = switchElement
		*/
		// Add any viewController
		/*let switchVC = ElementViewController()
		switchVC.elementView = UISwitch()
		
		if let switchElement = switchVC.elementView as? UISwitch {
		switchElement.addTarget(self, action: #selector(testFunc), for: .valueChanged)
		greenAction.contentViewController = switchVC
		}*/
		
		/*darkAlertController.addParallaxEffect(x: 20, y: 20)
		
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
		]*/
	}
	
	@objc internal func testFunc() {
		print("lol")
	}
}

