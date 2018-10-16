//
//  ListController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 16/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ListController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        view.addSubview(label)
    }
    

}
