//
//  BaseSlidingControllerViewController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 14/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class RightContainerView: UIView {}
class MenuContainerView: UIView {}
class DarkCoverView: UIView {}

class BaseSlidingController: UIViewController {
    
    let redView: RightContainerView = {
        let view = RightContainerView()
//        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let blueView: MenuContainerView = {
        let view = MenuContainerView()
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let darkCoverView: DarkCoverView = {
        let view = DarkCoverView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss))
        darkCoverView.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func handleTapDismiss() {
        closeMenu()
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstrant.constant = x
        darkCoverView.alpha = x / menuWidth
        
        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }
    
    func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        redViewTrailingConstrant.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstrant.constant = 0
        isMenuOpened = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpened ? .lightContent : .default
    }
    
    func didSelectMenuItem(indexPath: IndexPath) {
        performRightViewCleanUp()
        closeMenu()
        
        switch indexPath.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: HomeController())
            
        case 1:
            rightViewController = UINavigationController(rootViewController: ListController())
            
        case 2:
            rightViewController = BookmarksController()
            
        case 3:
            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.navigationItem.title = "Moments"
            momentsController.view.backgroundColor = .orange

            let testController = UIViewController()
            testController.view.backgroundColor = .green
            testController.tabBarItem.title = "Test"
            
            let navController = UINavigationController(rootViewController: momentsController)
            navController.tabBarItem.title = "moments"
            tabBarController.viewControllers = [navController, testController]
            rightViewController = tabBarController
            
        default:
            print("Show Moments Screen")
        }
        
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        redView.bringSubviewToFront(darkCoverView)
    }
    
//    var rightViewController: UIViewController?
    var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
//    let menuController = MenuController()
    let menuController = ChatroomMenuContainerController()
    
    fileprivate func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            // leave a reference link down in desc below
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstrant: NSLayoutConstraint!
    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate let velocityThreshold: CGFloat = 500
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        view.addSubview(darkCoverView)
        
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true
        
        redViewTrailingConstrant = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstrant.isActive = true
        
        setupViewControllers()
    }
    
    fileprivate func setupViewControllers() {
//        let homeController = HomeController()
        // reseting to normal VC
//        rightViewController = HomeController()
        
        let homeView = rightViewController.view!
        let menuView = menuController.view!
        
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(homeView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
                homeView.topAnchor.constraint(equalTo: redView.topAnchor),
                homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
                
                menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
                menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
                menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
                menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
                
                darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
                darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
                darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
                darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
        
        addChild(rightViewController)
        addChild(menuController)
    }

}
