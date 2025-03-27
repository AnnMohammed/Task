//
//  TabBarController.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let mapVC = UINavigationController(rootViewController: MapViewController())
        let dataVC = UINavigationController(rootViewController: DataListFactory.dataList.viewController)

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        mapVC.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 1)
        dataVC.tabBarItem = UITabBarItem(title: "Data", image: UIImage(systemName: "list.bullet"), tag: 2)

        self.viewControllers = [homeVC, mapVC, dataVC]
    }
}

