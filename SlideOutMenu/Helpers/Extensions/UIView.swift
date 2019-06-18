//
//  UIView.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 18/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach({addSubview($0)})
    }
    
}
