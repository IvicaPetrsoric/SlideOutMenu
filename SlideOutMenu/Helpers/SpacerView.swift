//
//  SpacerView.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 15/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class SpacerView: UIView {
    
    private let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
