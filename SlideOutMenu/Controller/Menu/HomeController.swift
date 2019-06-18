//
//  HomeController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 18/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UIGestureRecognizerDelegate {
    
    private let cellId = "cellId"
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Slide Left for Menu!"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        view.addSubview(infoLabel)
        infoLabel.fillSuperview()
        
        setupCircularNavigationButton()
    }
    
    private func setupCircularNavigationButton() {
        let image = #imageLiteral(resourceName: "girl_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.backgroundColor = .orange
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        customView.constrainHeight(constant: 40)
        customView.constrainWidth(constant: 40)
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
}
