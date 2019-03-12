//
//  TouchControllingView.swift
//  QiwiButtons
//
//  Created by r.makarov on 15/03/2018.
//  Copyright © 2018 QIWI. All rights reserved.
//

import UIKit


/// Touchable view. You can start dragging your finger from this button on UIScrollView and everything will work fine.
open class TouchControllingView: UIView {

    public func addAction<T: AnyObject>(target: T, method: @escaping (T) -> (() -> Void)) {
        touchUpInside = { [weak target] in
            guard let t = target else { return }
            method(t)()
        }
    }
    open var touchUpInside: (() -> Void)?

    open var isHighlighted: Bool = false
    open var isEnabled: Bool = true

    private static let outsideOffset: CGFloat = 30.0
    private static let defaultOffset: CGFloat = 15.0

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == .touches, isEnabled {
                isHighlighted = true
        }
        super.touchesBegan(touches, with: event)
    }

    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == .touches, let touch = touches.first, isEnabled {
            if !isPointAppliable(touch.location(in: self)) {
                isHighlighted = false
            }
        }
        super.touchesMoved(touches, with: event)
    }

    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == .touches, let touch = touches.first, isEnabled {
            isHighlighted = false
                if isPointAppliable(touch.location(in: self)) {
                    touchUpInside?()
                }
        }
        super.touchesEnded(touches, with: event)
    }

    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event?.type == .touches, isEnabled {
            isHighlighted = false
        }
        super.touchesCancelled(touches, with: event)
    }

    private func isPointAppliable(_ point: CGPoint) -> Bool {
        let offset = TouchControllingView.outsideOffset
        return point.x > -offset && point.x < bounds.width + offset && point.y > -offset && point.y < bounds.height + offset
    }

    open func animateAlpha(toValue: Double) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.alpha = CGFloat(toValue)
        })
    }
}
