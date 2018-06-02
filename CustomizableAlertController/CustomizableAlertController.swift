//
//  CustomizableAlertController.swift
//  CustomizableAlertController
//
//  Created by Daniel Illescas Romero on 07/01/2018.
//  Copyright © 2018 Daniel Illescas Romero. All rights reserved.
//

import UIKit

/*extension UIView {
	func changeColor(to color: UIColor) {
		self.backgroundColor = color
		for subview in self.subviews {
			subview.changeColor(to: color)
		}
	}
}*/

final class DarkAlertController: CustomizableAlertController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.visualEffectView?.effect = UIBlurEffect(style: .dark)
		
		self.tintColor = UIColor(red: 0.4, green: 0.5, blue: 1.0, alpha: 1.0)
		
		self.contentView?.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)

		let whiteStringAttribute = StringAttribute(key: .foregroundColor, value: UIColor.white)
		self.titleAttributes = [whiteStringAttribute]
		self.messageAttributes = [whiteStringAttribute]
	}
}

//

open class CustomizableAlertController: UIAlertController {
	
	open lazy var visualEffectView: UIVisualEffectView? = {
		return self.view.visualEffectView
	}()
	
	open lazy var lazyContentView: UIView? = {
		return self.contentView
	}()
	
	open lazy var tintColor: UIColor? = {
		return self.view.tintColor
	}()
	
	override open func viewWillAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.view.tintColor = self.tintColor
	}
	
	func addParallaxEffect(x: Int = 20, y: Int = 20) {
		let horizontal = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
		horizontal.minimumRelativeValue = -x
		horizontal.maximumRelativeValue = x
		
		let vertical = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
		vertical.minimumRelativeValue = -y
		vertical.maximumRelativeValue = y
		
		let motionEffectsGroup = UIMotionEffectGroup()
		motionEffectsGroup.motionEffects = [horizontal, vertical]
		
		self.view.addMotionEffect(motionEffectsGroup)
	}
}

//

extension UIAlertController {
	
	private var visualEffectView: UIVisualEffectView? {
		return self.view.visualEffectView
	}
	
	var contentView: UIView? {
		return self.view.subviews.first?.subviews.first?.subviews.first
	}
	
	var titleAttributes: [StringAttribute] {
		get { return self.attributedTitle_?.attributes ?? [] }
		set { self.attributedTitle_ = newValue.suitableAttributedText(forText: self.title) }
	}
	
	var messageAttributes: [StringAttribute] {
		get { return self.attributedMessage_?.attributes ?? [] }
		set { self.attributedMessage_ = newValue.suitableAttributedText(forText: self.message) }
	}
}

extension UIAlertAction {
	
	var label: UILabel? {
		return (self.value(forKey: "__representer") as? NSObject)?.value(forKey: "label") as? UILabel
	}
	
	var titleAttributes: [StringAttribute] {
		get { return self.label?.attributedText?.attributes ?? [] }
		set { self.label?.textAttributes = newValue }
	}
	
	var titleTextColor: UIColor? {
		get { return self.titleTextColor_ }
		set { self.titleTextColor_ = newValue }
	}
	
	var accessoryImage: UIImage? {
		get { return self.image_ }
		set { self.image_ = newValue }
	}
	
	var contentElementViewController: ElementViewController? {
		get { return self.contentViewController_ as? ElementViewController }
		set {
			if accessoryImage != nil {
				print("The accessory image might overlap with the content of the contentViewController")
			}
			self.contentViewController_ = newValue
		}
	}
	
	var contentViewController: UIViewController? {
		get { return self.contentViewController_ }
		set {
			if accessoryImage != nil {
				print("The accessory image might overlap with the content of the contentViewController")
			}
			self.contentViewController_ = newValue
		}
	}
	
	var tableViewController: UITableViewController? {
		get { return self.contentViewController_ as? UITableViewController }
		set {
			if accessoryImage != nil {
				print("The accessory image might overlap with the content of the contentViewController")
			}
			self.contentViewController_ = newValue
		}
	}
	
	var accessoryView: UIView? {
		get { return contentElementViewController?.elementView }
		set {
			let elementViewController = ElementViewController()
			elementViewController.elementView = newValue
			self.contentViewController = elementViewController
		}
	}
}

extension UILabel {
	var textAttributes: [StringAttribute] {
		get { return self.attributedText?.attributes ?? [] }
		set { self.attributedText = newValue.suitableAttributedText(forText: self.text) }
	}
}

extension NSAttributedString {
	
	struct StringAttribute {
		
		let key: NSAttributedStringKey
		let value: Any
		var range: NSRange? = nil
		
		init(key: NSAttributedStringKey, value: Any, range: NSRange? = nil) {
			self.key = key
			self.value = value
			self.range = range
		}
	}
	
	var attributes: [StringAttribute] {
		
		var savedAttributes: [StringAttribute] = []
		
		let rawAttributes = self.attributes(at: 0, longestEffectiveRange: nil, in: NSRange(location: 0, length: self.length))
		
		for rawAttribute in rawAttributes {
			savedAttributes.append(StringAttribute(key: rawAttribute.key, value: rawAttribute.value))
		}
		return savedAttributes
	}
	convenience init(string: String?, attributes: [StringAttribute]) {
		
		guard let validString = string else { self.init(string: "", attributes: [:]); return }
		
		var attributesDict: [NSAttributedStringKey: Any] = [:]
		for attribute in attributes {
			attributesDict[attribute.key] = attribute.value
		}
		self.init(string: validString, attributes: attributesDict)
	}
}

extension NSMutableAttributedString {
	var mutableAttributes: [StringAttribute] {
		get { return self.attributes }
		set {
			let defaultRange = NSRange(location: 0, length: self.length)
			for attribute in newValue {
				self.addAttribute(attribute.key, value: attribute.value, range: attribute.range ?? defaultRange)
			}
		}
	}
	convenience init(string: String?, mutableAttributes: [StringAttribute]) {
		guard let text = string else { self.init(string: ""); return }
		self.init(string: text)
		self.mutableAttributes = mutableAttributes
	}
}

class ElementViewController: UIViewController {
	
	var elementView: UIView? = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let validView = self.elementView  {
		
			self.view.addSubview(validView)
			
			validView.translatesAutoresizingMaskIntoConstraints = false
			
			let margins = self.view.layoutMarginsGuide
			
			validView.centerYAnchor.constraint(equalTo: margins.topAnchor, constant: validView.frame.height).isActive = true
			validView.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
			validView.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
			validView.heightAnchor.constraint(equalTo: margins.heightAnchor).isActive = true
		}
	}
}

//

typealias StringAttribute = NSAttributedString.StringAttribute

extension Array where Element == StringAttribute {
	func suitableAttributedText(forText text: String?) -> NSAttributedString {
		if self.compactMap({ $0.range }).isEmpty {
			return NSAttributedString(string: text, attributes: self)
		}
		return NSMutableAttributedString(string: text, mutableAttributes: self)
	}
}

extension UIView {
	func mapEverySubview(predicate: (UIView) -> Void) {
		predicate(self)
		for subview in self.subviews {
			subview.mapEverySubview(predicate: predicate)
		}
	}
}
private extension UIView {
	var visualEffectView: UIVisualEffectView? {
		
		if self is UIVisualEffectView {
			return self as? UIVisualEffectView
		}
		
		for subview in self.subviews {
			if let validView = subview.visualEffectView {
				return validView
			}
		}
		return nil
	}
}

private extension UIAlertController {
	
	private var attributedTitle_: NSAttributedString? {
		get {
			return self.value(forKey: "attributedTitle") as? NSAttributedString
		} set {
			self.setValue(newValue, forKey: "attributedTitle")
		}
	}
	
	private var attributedMessage_: NSAttributedString? {
		get {
			return self.value(forKey: "attributedMessage") as? NSAttributedString
		} set {
			self.setValue(newValue, forKey: "attributedMessage")
		}
	}
}

private extension UIAlertAction {
	
	// idea from: https://medium.com/@maximbilan/ios-uialertcontroller-customization-5cfd88140db8
	private var image_: UIImage? {
		get {
			return self.value(forKey: "image") as? UIImage
		} set {
			let imageWithGoodDimensions = newValue?.scale(to: CGSize(width: 30, height: 30))
			self.setValue(imageWithGoodDimensions?.withRenderingMode(.alwaysOriginal), forKey: "image")
		}
	}
	
	private var contentViewController_: UIViewController? {
		get {
			return self.value(forKey: "contentViewController") as? UIViewController
		} set {
			self.setValue(newValue, forKey: "contentViewController")
		}
	}
	
	private var titleTextColor_: UIColor? {
		get {
			return self.value(forKey: "titleTextColor") as? UIColor
		} set {
			self.setValue(newValue, forKey: "titleTextColor")
		}
	}
}
