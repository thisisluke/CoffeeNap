//
//  MainTabBarController.swift
//  CoffeeNap
//
//  Created by Luke Liu on 21/5/2024.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray

        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.navigationBar.prefersLargeTitles = true
        
        let settingNav = UINavigationController(rootViewController: settingVC)

        viewControllers = [homeNav, settingNav]
    }

    private lazy var homeVC: HomeViewController = {
        let homeVM = HomeViewModel()
        let homeVC = HomeViewController(viewModel: homeVM)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return homeVC
    }()

    private lazy var settingVC: UIViewController = {
        let settingVC = UIViewController()
        settingVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
        return settingVC
    }()
}
