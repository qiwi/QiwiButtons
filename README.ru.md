# QiwiButtons
Настраиваемые кнопки для iOS-приложений.

## TextButton
Царь-кнопка. Отображает текст и поддерживает стили, в которых должны быть указаны свойства для 3 состояний:
```
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
Текст кнопки настраивается через свойство ``title``. Состояние загрузки отображается, когда значение свойства ``isLoading`` равно ``true``.
Событие по нажатию устанавливается через метод ``addAction``.  Событие по нажатию с автоматической установкой состояния загрузки задаётся через метод ``addLoadingAction``.

### Требования
* iOS 9.0+

### Установка

#### CocoaPods
```
pod 'QiwiButtons', :git => 'https://github.com/qiwi/QiwiButtons'
```

#### Carthage
```
git "https://github.com/qiwi/QiwiButtons" "master"
```

### Пример использования:
```
let style = TextButton.Style(normal: stateNormal, highlighted: stateHighlighted, disabled: stateDisabled, activityIndicatorColor: activityIndicatorColor, borderWidth: borderWidth, cornerRadius: cornerRadius, height: height)
let textButton = TextButton(title: "Touch me", style: style)
textButton.addAction(target: viewModel, method: ViewModel.action)
// or: textButton.addLoadingAction(target: viewModel, method: ViewModel.loadingAction)

```

В тестовом приложении можно поиграться с разными свойствами кнопки и посмотреть их влияние на конечное отображение.
