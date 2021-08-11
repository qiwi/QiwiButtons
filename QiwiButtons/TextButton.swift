//
//  TextButton.swift
//  QiwiButtons
//
//  Created by r.makarov on 15/03/2018.
//  Copyright © 2018 QIWI. All rights reserved.
//

import Foundation
import UIKit

/// Button with text
@IBDesignable
@objc
open class TextButton: TouchControllingView {
    
    private(set) var heightConstraint: NSLayoutConstraint!
    
    public var style: Style = Style() {
        didSet {
            updateStyle()
        }
    }
    
    private func updateStyle() {
        currentState = getCurrentState()
        updateState()
        layer.borderWidth = style.borderWidth
		layer.cornerRadius = style.cornerRadius
		layer.masksToBounds = true
        activityIndicator.color = style.activityIndicatorColor
        if let height = style.height {
            heightConstraint.constant = height
            heightConstraint.isActive = true
        } else {
            heightConstraint.isActive = false
        }
        setNeedsLayout()
    }
    
    var currentState: State = State() {
        didSet {
            updateState()
        }
    }
    private func updateState() {
        layer.borderColor = currentState.borderColor.cgColor
        layer.backgroundColor = currentState.fillColor.cgColor
        titleLabel.attributedText = NSAttributedString(string: titleLabel.attributedText?.string ?? "", attributes: currentState.textAttributes)
    }
    
    override public var isHighlighted: Bool {
        didSet {
            currentState = getCurrentState()
        }
    }
    
    override public var isEnabled: Bool {
        didSet {
            currentState = getCurrentState()
        }
    }
    
    private func getCurrentState() -> State {
        if isHighlighted {
            return style.highlighted
        }
        if !isEnabled {
            return style.disabled
        }
        return style.normal
    }
    
    @IBInspectable
    public var title: String? {
        get {
            return titleLabel.attributedText?.string
        }
        set {
            titleLabel.attributedText = NSAttributedString(string: newValue ?? "", attributes: currentState.textAttributes)
			setAccessibilityLabelAndIdentifier()
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    public var isLoading: Bool = false {
        didSet {
            titleLabel.isHidden = isLoading
            self.isUserInteractionEnabled = !isLoading
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    private let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()

    /// Add action with loading state. If you touch this button you will see activityIndicatorView instead of text. You will see the text after the completion of the action.
    ///
    /// - Parameters:
    ///   - target: object which contains action method
    ///   - method: action method with completion
    public func addLoadingAction<T: AnyObject>(target: T, method: @escaping ((T) -> (@escaping () -> Void) -> Void)) {
        touchUpInside = { [weak target, weak self] in
            guard let t = target, let self = self else { return }
            self.isLoading = true
            method(t)({ [weak self] in
                self?.isLoading = false
            })
        }
    }
	
	public func addAction(_ action: @escaping () -> Void) {
		self.touchUpInside = action
	}
	
	public func addLoadingAction(_ action: @escaping (@escaping () -> Void) -> Void) {
		self.touchUpInside = { [weak self] in
			DispatchQueue.main.async {
				self?.isLoading = true
				action({
					DispatchQueue.main.async {
						self?.isLoading = false
					}
				})
			}
		}
	}

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: style.height ?? UIView.noIntrinsicMetric)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

	required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    public convenience init(title: String = "", style: Style = Style()) {
        self.init(frame: .zero)
        self.title = title
        self.style = style
        updateStyle()
		setAccessibilityLabelAndIdentifier()
    }
    
    private func commonInit(title: String = "", style: Style = Style()) {
        addSubview(titleLabel)
        addSubview(activityIndicator)
        createConstraints()
        self.title = title
        self.style = style
        updateStyle()
		
		isAccessibilityElement = true
		accessibilityTraits = .button
		setAccessibilityLabelAndIdentifier()
    }
	
	private func setAccessibilityLabelAndIdentifier() {
		accessibilityLabel = title
		accessibilityIdentifier = "button_\(title ?? "")"
	}

    private func createConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true

        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        heightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        heightConstraint.priority = .defaultLow
    }
}

public extension TextButton {
    
	struct State {
        public var borderColor: UIColor
        public var fillColor: UIColor
        public var textAttributes: [NSAttributedString.Key: Any]
        
        public init(borderColor: UIColor = .clear, fillColor: UIColor = .clear, textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key: Any]()) {
            
            self.borderColor = borderColor
            self.fillColor = fillColor
            self.textAttributes = textAttributes
        }
    }
    
	struct Style {
        public var normal = State()
        public var highlighted = State()
        public var disabled = State()
        
        public var activityIndicatorColor: UIColor = .gray
        public var borderWidth: CGFloat = 0
        public var cornerRadius: CGFloat = 0
        public var height: CGFloat?
        
		public init(normal: State = State(fillColor: .lightGray), highlighted: State = State(fillColor: .darkGray), disabled: State = State(), activityIndicatorColor: UIColor = .gray, borderWidth: CGFloat = 0, cornerRadius: CGFloat = 0, height: CGFloat = 44) {
            
            self.normal = normal
            self.highlighted = highlighted
            self.disabled = disabled
            self.activityIndicatorColor = activityIndicatorColor
            self.borderWidth = borderWidth
            self.cornerRadius = cornerRadius
            self.height = height
        }
    }
}
