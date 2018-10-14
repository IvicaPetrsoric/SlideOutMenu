//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 13/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    fileprivate let cellId = "cellId"
    fileprivate let menuController = MenuController()
    fileprivate let menuWidth: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .red
        setupNavigationItems()
        
        setupMenuController()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture : UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        if gesture.state == .changed {
            var x = translation.x
            x = min(menuWidth, x)
            x = max(0, x)
            
            // drag out menuController
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuController.view.transform = transform
            navigationController?.view.transform = transform
        
        } else if gesture.state == .ended {
            handleOpen()
        }
    }
    
    fileprivate func setupMenuController() {
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(menuController.view)
    }
    
    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = transform
//            self.view.transform = transform
            self.navigationController?.view.transform = transform
        })
    }
    
    @objc func handleOpen() {
        performAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
        addChild(menuController)
    }
    
    @objc func handleHide() {
        performAnimations(transform: .identity)
//        menuController.view.removeFromSuperview()
//        menuController.removeFromParent()
    }

    fileprivate func setupNavigationItems() {
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(handleOpen))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(handleHide))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = "Row: \(indexPath.row)"
        
        return cell
    }
    

}

