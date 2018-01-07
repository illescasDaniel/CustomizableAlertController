//
//  UIAlertAction+Extension.swift
//  CustomizableAlertController
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//

import UIKit

extension UIAlertController {
	func addAction(title: String, style: UIAlertActionStyle = .default, handler: ((UIAlertAction) -> Void)? = nil) {
		self.addAction(UIAlertAction(title: title, style: style, handler: handler))
	}
}
