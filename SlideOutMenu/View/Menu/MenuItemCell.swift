//
//  MenuItemCell.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 15/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    var menuItem: MenuItem? {
        didSet {
            guard let menuItem = menuItem else { return }
            
            iconImageView.image = menuItem.icon
            titleLabel.text = menuItem.title
        }
    }

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "profile")
        imageView.constrainWidth(constant: 44)
        imageView.constrainHeight(constant: 44)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, UIView()])
        stackView.spacing = 12

        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
