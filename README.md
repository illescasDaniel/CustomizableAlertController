#  CustomizableAlertController

Hacking the UIAlertController to fully customize it!

## Example

```swift
let customAlertController = CustomizableAlertController(title: "Do you want to do X?", message: ":D hii", preferredStyle: .alert)
customAlertController.addAction(title: "Yes", style: .default)
customAlertController.addAction(title: "Cancel", style: .cancel)

let greenAction = UIAlertAction(title: "I'm green!", style: .default)
customAlertController.addAction(greenAction)

customAlertController.addParallexEffect(x: 20, y: 20)

self.present(customAlertController, animated: true)

// customAlertController.lazyContentView?.backgroundColor = .red

customAlertController.titleAttributes += [
     StringAttribute(key: .font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: "Do ".count, length: "you".count)),
    StringAttribute(key: .font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: "Do you want to do ".count, length: "X".count))
]

customAlertController.messageAttributes += [
    StringAttribute(key: .foregroundColor, value: UIColor.orange, range: NSRange(location: 0, length: 3))
]

greenAction.titleAttributes = [
    StringAttribute(key: .foregroundColor, value: UIColor.green)
]
```
Medium article: X
