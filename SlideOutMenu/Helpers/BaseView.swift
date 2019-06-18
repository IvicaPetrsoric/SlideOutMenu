//
//  BaseView.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 18/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
