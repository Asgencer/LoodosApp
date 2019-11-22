//
//  TabBarViewController.swift
//  LoodosApp
//
//  Created by Semih Gençer on 19.11.2019.
//  Copyright © 2019 Semih Gençer. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let nav1 = UINavigationController(rootViewController: HomeViewController())
        nav1.tabBarItem.title = "Home"
        nav1.tabBarItem.selectedImage = UIImage(named: "home-selected")?.withRenderingMode(.alwaysOriginal)
        nav1.tabBarItem.image = UIImage(named: "home")?.withRenderingMode(.alwaysOriginal)
        
        let nav2 = UINavigationController(rootViewController: SearchViewController())
        nav2.title = "Search"
        nav2.tabBarItem.selectedImage = UIImage(named: "magnifier-selected")?.withRenderingMode(.alwaysOriginal)
        nav2.tabBarItem.image = UIImage(named: "magnifier")?.withRenderingMode(.alwaysOriginal)

        self.viewControllers = [nav1,nav2]
        
        self.tabBarController?.selectedIndex = 0
        self.tabBar.barTintColor = .black
        if let items = tabBar.items {
            // Setting the title text color of all tab bar items:
            for item in items {
                item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                item.setTitleTextAttributes([.foregroundColor: UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1)], for: .normal)
            }
        }
    }
}
