//
//  BaseSlidingControllerViewController.swift
//  SlideOutMenu
//
//  Created by ivica petrsoric on 14/10/2018.
//  Copyright © 2018 ivica petrsoric. All rights reserved.
//

import UIKit

class BaseSlidingController: UIViewController {
    
    lazy var rightViewController: UIViewController = UINavigationController(rootViewController: HomeController())
    private lazy var menuController = MenuController(delegate: self)
    
    private let leftContainerView = UIView()
    private let rightContainerView = UIView()
    
    let darkCoverView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        return view
    }()
    
    var rightViewLeadingConstraint: NSLayoutConstraint!
    var rightViewTrailingConstrant: NSLayoutConstraint!
    let menuWidth: CGFloat = 300
    var isMenuOpened = false
    let velocityThreshold: CGFloat = 500

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupViews()
        setupGestures()
    }

    private func setupViews() {
        view.addSubviews(rightContainerView, leftContainerView, darkCoverView)
        
        let anchoredConstraints = rightContainerView.anchor(top: view.topAnchor, leading: view.leadingAnchor,
                                                            bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        leftContainerView.anchor(top: view.topAnchor, leading: nil,
                        bottom: rightContainerView.bottomAnchor, trailing: rightContainerView.leadingAnchor,
                        size: .init(width: menuWidth, height: 0))
        
        (rightViewLeadingConstraint, rightViewTrailingConstrant) = (anchoredConstraints.leading, anchoredConstraints.trailing)
  
        darkCoverView.anchor(top: rightContainerView.topAnchor, leading: rightContainerView.leadingAnchor,
                             bottom: rightContainerView.bottomAnchor, trailing: rightContainerView.trailingAnchor)
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        guard let homeView = rightViewController.view else { return }
        guard let menuView = menuController.view else { return }
        
        rightContainerView.addSubview(homeView)
        leftContainerView.addSubview(menuView)
        
        homeView.anchor(top: rightContainerView.topAnchor, leading: rightContainerView.leadingAnchor,
                        bottom: rightContainerView.bottomAnchor, trailing: rightContainerView.trailingAnchor)
        
        menuView.anchor(top: leftContainerView.topAnchor, leading: leftContainerView.leadingAnchor,
                        bottom: leftContainerView.bottomAnchor, trailing: leftContainerView.trailingAnchor)
        
        addChild(rightViewController)
        addChild(menuController)
    }
    
    fileprivate func performRightViewCleanUp() {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpened ? .lightContent : .default
    }

}

extension BaseSlidingController: MenuControllerDelegate {
    
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
        
        rightContainerView.addSubview(rightViewController.view)
        addChild(rightViewController)
        
        rightContainerView.bringSubviewToFront(darkCoverView)
    }
    
}
