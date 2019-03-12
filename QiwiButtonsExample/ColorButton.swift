//
//  ColorButton.swift
//  QiwiButtonsExample
//
//  Created by Mikhail Motyzhenkov on 28/09/2018.
//  Copyright © 2018 Qiwi. All rights reserved.
//

import Foundation
import UIKit

final class ColorButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customInit()
    }
    
    private func customInit() {
        setTitle(nil, for: .normal)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.withAlphaComponent(0.25).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
		layer.cornerRadius = bounds.height/2
		layer.masksToBounds = true
    }
}
