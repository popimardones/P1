//
//  TabBarController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/23/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//


import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let index = viewControllers?.index(of: viewController)
        if index == 1 {
            
            //let layout = UICollectionViewFlowLayout()
            //let photoSelectorController = PhotoSelectorController(collectionViewLayout: layout)
            let registerGuestsController = RegisterGuestsController()
            let navController = UINavigationController(rootViewController: registerGuestsController)
            
            present(navController, animated: true, completion: nil)
            
            return false
        }
        
        
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        if Auth.auth().currentUser == nil {
            //show if not logged in
            DispatchQueue.main.async {
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
//                let tutorialController = TutorialController()
//                let navController = UINavigationController(rootViewController: tutorialController)
//                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
        
        setupViewControllers()
        
    }
    
    func setupViewControllers() {
        
        let homeController = HomeController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected") , rootViewController: homeController)
        
//        //1
//        let joinCommunityController = JoinCommunityController()
//        let joinCommunityNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "community_unselected"), selectedImage: #imageLiteral(resourceName: "community_selected") , rootViewController: joinCommunityController)
        
        //2
        let registerGuestsController = RegisterGuestsController()
        let registerGuestsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "community_unselected"), selectedImage: #imageLiteral(resourceName: "community_selected") , rootViewController: registerGuestsController)
        
        //3
        let userProfileController = UserProfileController2()
        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected") , rootViewController: userProfileController)
        
//        //3
//        let userProfileController = UserProfileTableViewController()
//        let userProfileNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected") , rootViewController: userProfileController)
        
        tabBar.tintColor = .blueGray()
        UITabBar.appearance().barTintColor = .darkBlue()
        UITabBar.appearance().isTranslucent = false
        
        
        viewControllers = [homeNavController,
                           registerGuestsNavController,
                           userProfileNavController]
        
        //modify tab bar item insets
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
    }
    
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
    
    
}

