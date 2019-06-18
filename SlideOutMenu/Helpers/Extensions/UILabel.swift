//
//  UILabel.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 18/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}
