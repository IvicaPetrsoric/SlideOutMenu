//
//  ListController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 16/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class ListController: UIViewController {
    
    private let listsLabel: UILabel = {
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        navigationItem.title = "Lists"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(listsLabel)
        listsLabel.fillSuperview()
    }
    
}
