//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 13/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class HomeController: UITableViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .red
        
        setupNavigationItems()

    }
    
    @objc func handleOpen() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        
        setupCircularNavigationButton()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    fileprivate func setupCircularNavigationButton() {
        let image = #imageLiteral(resourceName: "girl_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.backgroundColor = .orange
        customView.addTarget(self, action: #selector(handleOpen), for: .touchUpInside)
//        customView.imageView?.image // this is wrong!
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
//        customView.frame = CGRect(x: 0, y: 0, width: 40, height: 40) // not working
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleOpen))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }

}

