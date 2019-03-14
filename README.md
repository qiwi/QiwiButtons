# QiwiButtons
Customizable buttons for iOS apps.

## TextButton
A button with a text. It supports styles for 3 states:
```swift
public struct Style {
  public var normal: State
  public var highlighted: State
  public var disabled: State

  public var activityIndicatorColor: UIColor
  public var borderWidth: CGFloat
  public var cornerRadius: CGFloat
  public var height: CGFloat?
}

public struct State {
  public var borderColor: UIColor
  public var fillColor: UIColor
  public var textAttributes: [NSAttributedString.Key: Any]
}
```
You can change button's text via ``title`` property. If ``isLoading`` is equal to ``true`` you will see activity indicator.
Add action with ``addAction`` method.  Add loading action with ``addLoadingAction`` method.

### Requirements
* iOS 9.0+

### Installation

#### CocoaPods
```
pod 'QiwiButtons', :git => 'https://github.com/qiwi/QiwiButtons'
```

#### Carthage
```
git "https://github.com/qiwi/QiwiButtons" "master"
```

### Usage example:

```swift
let style = TextButton.Style(normal: stateNormal, highlighted: stateHighlighted, disabled: stateDisabled, activityIndicatorColor: activityIndicatorColor, borderWidth: borderWidth, cornerRadius: cornerRadius, height: height)
let textButton = TextButton(title: "Touch me", style: style)
textButton.addAction(target: viewModel, method: ViewModel.action)
// or: textButton.addLoadingAction(target: viewModel, method: ViewModel.loadingAction)

```

You can play with different properties and states of this button in the QiwiButtonsExample target. 
