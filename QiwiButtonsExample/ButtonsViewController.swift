//
//  ButtonsViewController.swift
//  QiwiButtonsExample
//
//  Created by Mikhail Motyzhenkov on 27/09/2018.
//  Copyright © 2018 Qiwi. All rights reserved.
//

import Foundation
import QiwiButtons
import UIKit

final class ButtonsViewController: UIViewController {
    
    @IBOutlet weak var whippingBoy: TextButton!
    @IBOutlet weak var labelHeight: UILabel!
    @IBOutlet weak var labelCornerRadius: UILabel!
    @IBOutlet weak var labelBorderWidth: UILabel!
    @IBOutlet weak var labelNormalFontSize: UILabel!
    @IBOutlet weak var labelHighlightedFontSize: UILabel!
    @IBOutlet weak var labelDisabledFontSize: UILabel!
    
    var stateNormal: TextButton.State!
    var stateHighlighted: TextButton.State!
    var stateDisabled: TextButton.State!
    
    var activityIndicatorColor: UIColor! = .white
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat = 0
    var height: CGFloat = 48
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.title = NSLocalizedString("title", comment: "")
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
        stateNormal = TextButton.State(fillColor: .orange, textAttributes: attributes)
        stateHighlighted = TextButton.State(fillColor: .red, textAttributes: attributes)
        stateDisabled = TextButton.State(fillColor: .lightGray, textAttributes: attributes)
        updateStyle()
    }
    
    func updateStyle() {
        whippingBoy.style = TextButton.Style(normal: stateNormal, highlighted: stateHighlighted, disabled: stateDisabled, activityIndicatorColor: activityIndicatorColor, borderWidth: borderWidth, cornerRadius: cornerRadius, height: height)
    }
    
    @IBAction func heightChanged(_ sender: UIStepper) {
        height = CGFloat(sender.value)
        labelHeight.text = String(Int(sender.value))
        updateStyle()
    }
    
    @IBAction func cornerRadiusChanged(_ sender: UIStepper) {
        cornerRadius = CGFloat(sender.value)
        labelCornerRadius.text = String(Int(sender.value))
        updateStyle()
    }
    
    @IBAction func borderWidthChanged(_ sender: UIStepper) {
        borderWidth = CGFloat(sender.value)
        labelBorderWidth.text = String(Int(sender.value))
        updateStyle()
    }
    
    @IBAction func activityColorChanged(_ sender: ColorButton) {
        activityIndicatorColor = sender.backgroundColor
        updateStyle()
    }
    
    @IBAction func disabledTouched(_ sender: UISwitch) {
        whippingBoy.isEnabled = !sender.isOn
    }
    
    @IBAction func loadingTouched(_ sender: UISwitch) {
        whippingBoy.isLoading = sender.isOn
    }
    
    @IBAction func normalBorderColorChanged(_ sender: ColorButton) {
        stateNormal.borderColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func normalFillColorChanged(_ sender: ColorButton) {
        stateNormal.fillColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func normalFontSizeChanged(_ sender: UIStepper) {
        stateNormal.textAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: CGFloat(sender.value))
        labelNormalFontSize.text = String(Int(sender.value))
        updateStyle()
    }
    
    @IBAction func highlightedBorderColorChanged(_ sender: ColorButton) {
        stateHighlighted.borderColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func highlightedFillColorChanged(_ sender: ColorButton) {
        stateHighlighted.fillColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func highlightedFontSizeChanged(_ sender: UIStepper) {
        stateHighlighted.textAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: CGFloat(sender.value))
        labelHighlightedFontSize.text = String(Int(sender.value))
        updateStyle()
    }
    
    @IBAction func disabledBorderColorChanged(_ sender: ColorButton) {
        stateDisabled.borderColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func disabledFillColorChanged(_ sender: ColorButton) {
        stateDisabled.fillColor = sender.backgroundColor!
        updateStyle()
    }
    
    @IBAction func disabledFontSizeChanged(_ sender: UIStepper) {
        stateDisabled.textAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: CGFloat(sender.value))
        labelDisabledFontSize.text = String(Int(sender.value))
        updateStyle()
    }
}
