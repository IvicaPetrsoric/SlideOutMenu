//
//  SearchContainerView.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 18/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class SearchContainerView: BaseView {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Enter some filer"
        return searchBar
    }()
    
    private let rocketImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "rocket"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    init(searchBarDelegate: UISearchBarDelegate) {
        super.init(frame: .zero)
        
        searchBar.delegate = searchBarDelegate
    }
    
    override func setupViews() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        
        addSubviews(searchBar, rocketImageView)
        
        rocketImageView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor,
                               bottom: bottomAnchor, trailing: nil,
                               padding: .init(top: 0, left: 10, bottom: 10, right: 0),
                               size: .init(width: 44, height: 44))
        
        searchBar.anchor(top: nil, leading: rocketImageView.trailingAnchor,
                         bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 4, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
