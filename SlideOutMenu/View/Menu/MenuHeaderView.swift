//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 15/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class MenuHeaderView: BaseView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ivek"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    private let userNameLabel = UILabel(text: "Perić", font: UIFont.systemFont(ofSize: 14))
    
    private let statsLabel = UILabel()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "girl_profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 48 / 2
        imageView.clipsToBounds = true
        imageView.constrainWidth(constant: 48)
        imageView.constrainHeight(constant: 48)
        return imageView
    }()
    
    override func setupViews() {
        backgroundColor = .white
        
        setupStatsAttributedText()
        setupStackView()
    }
    
    private func setupStatsAttributedText() {
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
    }
    
    private func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            UIStackView(arrangedSubviews: [profileImageView, UIView()]),
            nameLabel,
            userNameLabel,
            SpacerView(space: 16),
            statsLabel
            ])
        stackView.axis = .vertical
        stackView.spacing = 4
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
    
}
