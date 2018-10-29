//
//  UIAlertAction+Extension.swift
//  CustomizableAlertController
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//

import UIKit

extension UIAlertController {
	func addAction(title: String, style: UIAlertAction.Style = .default, image: UIImage? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
		self.addAction(UIAlertAction(title: title, style: style, image: image, handler: handler))
	}
}

extension UIAlertAction {
	convenience init(title: String, style: UIAlertAction.Style = .default, image: UIImage?, handler: ((UIAlertAction) -> Void)? = nil) {
		self.init(title: title, style: style, handler: handler)
		if let image = image {
			self.accessoryImage = image
		}
	}
}
