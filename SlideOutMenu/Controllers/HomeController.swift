//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 13/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class HomeController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = .red
        setupNavigationItems()
        
        setupMenuController()
        
        // Pan Gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if gesture.state == .changed {
            var x = translation.x
            
            if isMenuOpened {
                // make sure you go through this logic line by line
                x += menuWidth
            }
            
            x = min(menuWidth, x)
            x = max(0, x)
            
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuController.view.transform = transform
            navigationController?.view.transform = transform
            
        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        let velocity = gesture.velocity(in: view)
        print("Velocity: ",velocity.x)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityOpenThreshold {
                handleHide()
                return
            }
            
            if abs(translation.x) < menuWidth / 2 {
                handleOpen()
            } else {
                handleHide()
            }
        } else {
            if velocity.x > velocityOpenThreshold {
                handleOpen()
                return
            }
            
            if translation.x < menuWidth / 2 {
                handleHide()
            } else {
                handleOpen()
            }
        }
    }
    
    let menuController = MenuController()
    
    fileprivate let velocityOpenThreshold: CGFloat = 500
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    
    fileprivate func performAnimations(tranform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.menuController.view.transform = tranform
            //            self.view.transform = tranform
            // I'll let you think about this on your own
            self.navigationController?.view.transform = tranform
        })
    }
    
    @objc func handleOpen() {
        isMenuOpened = true
        performAnimations(tranform: CGAffineTransform(translationX: self.menuWidth, y: 0))
    }
    
    @objc func handleHide() {
        isMenuOpened = false
        performAnimations(tranform: .identity)
    }
    
    // MARK:- Fileprivate
    
    fileprivate func setupMenuController() {
        // initial position
        menuController.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuController.view)
        addChild(menuController)
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
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        
        cell.textLabel?.text = "Row: \(indexPath.row)"
        
        return cell
        
    }


}

